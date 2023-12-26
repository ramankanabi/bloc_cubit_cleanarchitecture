import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_course/1_domain/entities/advice_entity.dart';

class AdviceModel extends AdviceEntity with EquatableMixin {
  AdviceModel({required super.id, required super.advice});

  factory AdviceModel.fromMap(Map<String, dynamic> map) {
    return AdviceModel(
      id: map["advice_id"] as int,
      advice: map["advice"] as String,
    );
  }
}
