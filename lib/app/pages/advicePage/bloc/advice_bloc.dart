// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advice_event.dart';
part 'advice_state.dart';



class AdviceBloc extends Bloc<AdviceEvent, AdviceState> {
  AdviceBloc() : super(AdviceStateInitial()) {
    on<AdviceRequestData>((event, emit) async {
      emit(AdviceStateLoading());

      debugPrint("the request has triggered");

      await Future.delayed(const Duration(seconds: 3));

      debugPrint("the data succefully has been gotten");
      emit(AdviceStateLoaded("helloo from my bottm of heart"));
    });
  }
}
