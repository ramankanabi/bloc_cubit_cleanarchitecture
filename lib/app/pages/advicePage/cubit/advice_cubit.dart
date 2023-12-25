import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceState> {
  AdviceCubit() : super(AdviceStateInitial());

  adviceRequestData() async {
    emit(AdviceStateLoading());

    debugPrint("the request has triggered");

    await Future.delayed(const Duration(seconds: 3));

    debugPrint("the data succefully has been gotten");
    emit(const AdviceStateLoaded("helloo from my bottm of heart"));
  }
}
