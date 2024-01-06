import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_course/0_data/datasources/advice_remote_datasource.dart';
import 'package:flutter_bloc_course/0_data/exceptions/exceptions.dart';
import 'package:flutter_bloc_course/0_data/models/advice_model.dart';
import 'package:flutter_bloc_course/0_data/repositories/advice_repo_impl.dart';
import 'package:flutter_bloc_course/1_domain/failures/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advicr_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRemoteDataSourceImpl>()])
void main() {
  group("AdviceRepoImpl", () {
    final mockAdviceRemoteDataSource = MockAdviceRemoteDataSourceImpl();
    final adviceRepoImplUnderTest =
        AdviceRepoImpl(adviceRemoteDatasource: mockAdviceRemoteDataSource);
    group("Should return Advice entity", () {
      test("when advice remote data source return advice model", () async {
        when(mockAdviceRemoteDataSource.getRandomAdviceFromapi()).thenAnswer(
            (_) => Future.value(AdviceModel(id: 1, advice: "test")));

        final result = await adviceRepoImplUnderTest.getAdviceFromDataSource();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
          result,
          Right<Failure, AdviceModel>(
            AdviceModel(id: 1, advice: "test"),
          ),
        );
      });
    });

    group("should return left", () {
      test("A ServerFailure when ServerEcpetion occurs", () async {
        when(mockAdviceRemoteDataSource.getRandomAdviceFromapi())
            .thenThrow(ServerException());

        final result = await adviceRepoImplUnderTest.getAdviceFromDataSource();

        expect(result.isRight(), false);
        expect(result.isLeft(), true);
        expect(result, Left<Failure, AdviceModel>(ServerFailure()));
      });

      test("A GeneralFailure on all other Exceptions", () async {
        when(mockAdviceRemoteDataSource.getRandomAdviceFromapi())
            .thenThrow(const SocketException("test"));

        final result = await adviceRepoImplUnderTest.getAdviceFromDataSource();

        expect(result.isRight(), false);
        expect(result.isLeft(), true);
        expect(result, Left<Failure, AdviceModel>(GeneralFailure()));
      });
    });
  });
}
