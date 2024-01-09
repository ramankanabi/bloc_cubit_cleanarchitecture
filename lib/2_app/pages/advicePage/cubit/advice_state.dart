part of 'advice_cubit.dart';

sealed class AdviceCubitState extends Equatable {
  const AdviceCubitState();

  @override
  List<Object?> get props => [];
}

final class AdviceStateInitial extends AdviceCubitState {
  const AdviceStateInitial();
}

final class AdviceStateLoading extends AdviceCubitState {
  const AdviceStateLoading();
}

final class AdviceStateLoaded extends AdviceCubitState {
  final String advice;
  const AdviceStateLoaded(this.advice);

  @override
  List<Object?> get props => [advice];
}

final class AdviceStateError extends AdviceCubitState {
  final String message;
  const AdviceStateError(this.message);

  @override
  List<Object?> get props => [message];
}
