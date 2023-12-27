import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_course/1_domain/entities/advice_entity.dart';
import 'package:flutter_bloc_course/1_domain/failures/failure.dart';
import 'package:flutter_bloc_course/1_domain/repositories/advice_repository.dart';

class AdviceUseCase {
  final AdviceRepo adviceRepo;
  AdviceUseCase({required this.adviceRepo});
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDataSource();
  }
}
