part of 'advice_cubit.dart';

sealed class AdviceState extends Equatable {
  const AdviceState();

  @override
  List<Object?> get props => [];
}

final class AdviceStateInitial extends AdviceState {}

final class AdviceStateLoading extends AdviceState {}

final class AdviceStateLoaded extends AdviceState {
  final String advice;
  const AdviceStateLoaded(this.advice);

  @override
  List<Object?> get props => [advice];
}

final class AdviceStateError extends AdviceState {
  final String message;
  const AdviceStateError(this.message);

  @override
  List<Object?> get props => [message];
}
