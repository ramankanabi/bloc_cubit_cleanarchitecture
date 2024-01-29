import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_course/2_app/pages/advicePage/advice_page.dart';
import 'package:flutter_bloc_course/2_app/pages/advicePage/cubit/advice_cubit.dart';
import 'package:flutter_bloc_course/2_app/pages/advicePage/widgets/advice_field.dart';
import 'package:flutter_bloc_course/2_app/pages/advicePage/widgets/error_message.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAdviceCubit extends MockCubit<AdviceCubitState>
    implements AdviceCubit {}

void main() {
  Widget widgetUnderTest({required AdviceCubit cubit}) {
    return MaterialApp(
      home: BlocProvider<AdviceCubit>(
        create: (context) => cubit,
        child: const AdvicerPage(),
      ),
    );
  }

  group(
    'AdvicerPage',
    () {
      late AdviceCubit mockAdvicerCubit;

      setUp(
        () {
          mockAdvicerCubit = MockAdviceCubit();
        },
      );
      group(
        'should be displayed in ViewState',
        () {
          testWidgets(
            'Initial when cubits emits AdvicerInitial()',
            (widgetTester) async {
              whenListen(
                mockAdvicerCubit,
                Stream.fromIterable(const [AdviceStateInitial()]),
                initialState: const AdviceStateInitial(),
              );

              await widgetTester
                  .pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));

              final advicerInitalTextFinder =
                  find.text('Your Advice is waiting for you!');

              expect(advicerInitalTextFinder, findsOneWidget);
            },
          );

          testWidgets(
            'Loading when cubits emits AdvicerStateLoading()',
            (widgetTester) async {
              whenListen(
                mockAdvicerCubit,
                Stream.fromIterable(const [AdviceStateLoading()]),
                initialState: const AdviceStateInitial(),
              );

              await widgetTester
                  .pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
              await widgetTester.pump(); //use for animation stuff

              final advicerLoadingFinder =
                  find.byType(CircularProgressIndicator);

              expect(advicerLoadingFinder, findsOneWidget);
            },
          );

          testWidgets(
            'advice text when cubits emits AdvicerStateLoaded()',
            (widgetTester) async {
              whenListen(
                mockAdvicerCubit,
                Stream.fromIterable(const [AdviceStateLoaded('42')]),
                initialState: const AdviceStateInitial(),
              );

              await widgetTester
                  .pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
              await widgetTester.pump();

              final advicerLoadedStateFinder = find.byType(AdviceField);
              final adviceText = widgetTester
                  .widget<AdviceField>(advicerLoadedStateFinder)
                  .advice;

              expect(advicerLoadedStateFinder, findsOneWidget);
              expect(adviceText, '42');
            },
          );

          testWidgets(
            'Error when cubits emits AdvicerStateError()',
            (widgetTester) async {
              whenListen(
                mockAdvicerCubit,
                Stream.fromIterable(const [AdviceStateError('error')]),
                initialState: const AdviceStateInitial(),
              );

              await widgetTester
                  .pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
              await widgetTester.pump();

              final advicerErrorFinder = find.byType(ErrorMessage);

              expect(advicerErrorFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
