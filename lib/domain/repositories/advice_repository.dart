import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_course/domain/entities/advice_entity.dart';
import 'package:flutter_bloc_course/domain/failures/failure.dart';

abstract class AdviceRepo {
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource();
}
