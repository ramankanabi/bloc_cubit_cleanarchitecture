import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_course/1_domain/failures/failure.dart';
import 'package:flutter_bloc_course/1_domain/usecases/advice_usecase.dart';

part 'advice_state.dart';

const serverErrorMessage = "Ops, Api error , please try again";
const cacheErrorMessage = "Oops, Cache error, please try again";
const defaultEttotMessage = "Oops, Something went wrong";

class AdviceCubit extends Cubit<AdviceCubitState> {
  AdviceCubit({required this.adviceUsecase})
      : super(const AdviceStateInitial());
  final AdviceUseCase adviceUsecase;
  adviceRequestData() async {
    emit(const AdviceStateLoading());
    final failureOrAdvice = await adviceUsecase.getAdvice();
    failureOrAdvice.fold(
        (failure) => emit(AdviceStateError(_failureMessage(failure))),
        (advice) => emit(AdviceStateLoaded(advice.advice)));
  }
}

String _failureMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverErrorMessage;

    case CacheFailure:
      return cacheErrorMessage;

    default:
      return defaultEttotMessage;
  }
}
