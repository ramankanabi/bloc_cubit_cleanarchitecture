import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_course/1_domain/entities/advice_entity.dart';
import 'package:flutter_bloc_course/1_domain/failures/failure.dart';
import 'package:flutter_bloc_course/1_domain/usecases/advice_usecase.dart';
import 'package:flutter_bloc_course/2_app/pages/advicePage/cubit/advice_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Note. mocktail is doing same work with Mockito , but mocktail doesnt genereate any auto files and used buy BlocTest
class MocktailAdviceUseCase extends Mock implements AdviceUseCase {}

void main() {
  group(
    "AdviceCubit",
    () {
      final MocktailAdviceUseCase mocktailAdviceUseCase =
          MocktailAdviceUseCase();
      group("should emit", () {
        blocTest(
          "Nothinh when no method is called",
          build: () => AdviceCubit(
            adviceUsecase: mocktailAdviceUseCase,
          ),
          expect: () => [],
        );

        blocTest(
          "[AdviceLoadding,AdviceLoaded] when adviceRequest is called",
          build: () => AdviceCubit(
            adviceUsecase: mocktailAdviceUseCase,
          ),
          setUp: () => when(() => mocktailAdviceUseCase.getAdvice()).thenAnswer(
              (invocation) => Future.value(
                  const Right(AdviceEntity(id: 1, advice: "test")))),
          act: (cubit) => cubit.adviceRequestData(),
          expect: () => const <AdviceCubitState>[
            AdviceStateLoading(),
            AdviceStateLoaded("test")
          ],
        );
      });

      group(
        '[AdvicerStateLoading, AdvicerStateError] when adviceRequested() is called',
        () {
          blocTest(
            'and a ServerFailure occors',
            setUp: () =>
                when(() => mocktailAdviceUseCase.getAdvice()).thenAnswer(
              (invocation) => Future.value(
                Left<Failure, AdviceEntity>(
                  ServerFailure(),
                ),
              ),
            ),
            build: () => AdviceCubit(adviceUsecase: mocktailAdviceUseCase),
            act: (cubit) => cubit.adviceRequestData(),
            expect: () => const <AdviceCubitState>[
              AdviceStateLoading(),
              AdviceStateError(serverErrorMessage),
            ],
          );

          blocTest(
            'and a CacheFailure occors',
            setUp: () =>
                when(() => mocktailAdviceUseCase.getAdvice()).thenAnswer(
              (invocation) => Future.value(
                Left<Failure, AdviceEntity>(
                  CacheFailure(),
                ),
              ),
            ),
            build: () => AdviceCubit(adviceUsecase: mocktailAdviceUseCase),
            act: (cubit) => cubit.adviceRequestData(),
            expect: () => const <AdviceCubitState>[
              AdviceStateLoading(),
              AdviceStateError(cacheErrorMessage),
            ],
          );

          blocTest(
            'and a GeneralFailure occors',
            setUp: () =>
                when(() => mocktailAdviceUseCase.getAdvice()).thenAnswer(
              (invocation) => Future.value(
                Left<Failure, AdviceEntity>(
                  GeneralFailure(),
                ),
              ),
            ),
            build: () => AdviceCubit(adviceUsecase: mocktailAdviceUseCase),
            act: (cubit) => cubit.adviceRequestData(),
            expect: () => const <AdviceCubitState>[
              AdviceStateLoading(),
              AdviceStateError(defaultEttotMessage),
            ],
          );
        },
      );
    },
  );
}
