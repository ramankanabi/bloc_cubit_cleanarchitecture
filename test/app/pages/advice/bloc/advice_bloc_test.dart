import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_course/2_app/pages/advicePage/bloc/advice_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("AdvicerBloc", () {
    group("should emit", () {
      blocTest<AdviceBloc, AdviceState>(
        "nothing when no event added",
        build: () => AdviceBloc(),
        expect: () => [],
      );

      blocTest<AdviceBloc, AdviceState>(
        "[AdviceStateLoading,AdviceStateLoaded] when AdviceRequestdEvent is added",
        build: () => AdviceBloc(),
        act: (bloc) => bloc.add(AdviceRequestData()),
        wait: const Duration(seconds: 3),
        expect: () => [
          AdviceStateLoading(),
          AdviceStateLoaded("helloo from my bottm of heart")
        ],
      );
    });
  });
}
