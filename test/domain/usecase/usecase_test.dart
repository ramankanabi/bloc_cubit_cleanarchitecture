import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_course/1_domain/entities/advice_entity.dart';
import 'package:flutter_bloc_course/1_domain/failures/failure.dart';
import 'package:flutter_bloc_course/1_domain/repositories/advice_repository.dart';
import 'package:flutter_bloc_course/1_domain/usecases/advice_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepo>()])
void main() {
  group("Usecase test", () {
    final mockAdviceRepo = MockAdviceRepo();
    final adviceUsecaseUnderTest = AdviceUseCase(adviceRepo: mockAdviceRepo);
    group("should return Right", () {
      test("should return advice entity", () async {
        const value = Right<Failure, AdviceEntity>(
          AdviceEntity(id: 1, advice: "test"),
        );
        when(mockAdviceRepo.getAdviceFromDataSource()).thenAnswer(
          (realInvocation) => Future.value(
            value,
          ),
        );
        final result = await adviceUsecaseUnderTest.getAdvice();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(result, value);
      });
    });

    group("should return Left", () {
      test("should return GeneralFailure", () async {
        when(mockAdviceRepo.getAdviceFromDataSource()).thenAnswer(
            (realInvocation) => Future.value(Left(GeneralFailure())));
        final result = await adviceUsecaseUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left(GeneralFailure()));
      });
      test("should return SeverFailure", () async {
        when(mockAdviceRepo.getAdviceFromDataSource()).thenAnswer(
            (realInvocation) => Future.value(Left(ServerFailure())));
        final result = await adviceUsecaseUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left(ServerFailure()));
      });
    });
  });
}
