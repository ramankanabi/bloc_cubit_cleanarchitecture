import "package:flutter_bloc_course/0_data/datasources/advice_remote_datasource.dart";
import "package:flutter_bloc_course/0_data/exceptions/exceptions.dart";
import "package:flutter_bloc_course/0_data/models/advice_model.dart";
import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart" as http;
import 'package:mockito/annotations.dart';
import "package:mockito/mockito.dart";

import "advice_remote_datasource_test.mocks.dart";

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  group("AdviceRemoteDataSource", () {
    final mockClient = MockClient();
    final advideRemoteDataSourceUnderTest =
        AdviceRemoteDataSourceImpl(client: mockClient);
    group("should return advice model ", () {
      test("when client response was 200 and has valid data", () async {
        const responseBody = '{"advice_id": 1, "advice": "test advice"}';

        when(
          mockClient.get(
            Uri.parse('https://api.flutter-community.com/api/v1/advice'),
            headers: {
              'content-type': 'application/json ',
            },
          ),
        ).thenAnswer(
            (realInvocation) => Future.value(http.Response(responseBody, 200)));

        final result =
            await advideRemoteDataSourceUnderTest.getRandomAdviceFromapi();

        expect(result, AdviceModel(id: 1, advice: "test advice"));
      });
    });

    group("should throw", () {
      test("a ServerException when client response was not 200 ", () {
        when(
          mockClient.get(
            Uri.parse('https://api.flutter-community.com/api/v1/advice'),
            headers: {
              'content-type': 'application/json ',
            },
          ),
        ).thenAnswer((realInvocation) => Future.value(http.Response("", 201)));

        expect(() => advideRemoteDataSourceUnderTest.getRandomAdviceFromapi(),
            throwsA(isA<ServerException>()));
      });

      test("a Type Error when client response was 200 and has not vaid data",
          () {
        const responseBody = '{"advice": "test advice"}';

        when(
          mockClient.get(
            Uri.parse('https://api.flutter-community.com/api/v1/advice'),
            headers: {
              'content-type': 'application/json ',
            },
          ),
        ).thenAnswer(
            (realInvocation) => Future.value(http.Response(responseBody, 200)));

        expect(() => advideRemoteDataSourceUnderTest.getRandomAdviceFromapi(),
            throwsA(isA<TypeError>()));
      });
    });
  });
}
