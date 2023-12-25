import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_course/domain/failures/failure.dart';
import 'package:flutter_bloc_course/domain/usecases/advice_usecase.dart';

part 'advice_state.dart';

const serverErrorMessage = "Ops, Api error , please try again";
const cacheErrorMessage = "Oops, Cache error, please try again";
const defaultEttotMessage = "Oops, Something went wrong";

class AdviceCubit extends Cubit<AdviceState> {
  AdviceCubit() : super(AdviceStateInitial());
  final adviceUsecase = AdviceUseCase();
  adviceRequestData() async {
    emit(AdviceStateLoading());
    final failureOrAdvice = await adviceUsecase.getAdvoce();
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
