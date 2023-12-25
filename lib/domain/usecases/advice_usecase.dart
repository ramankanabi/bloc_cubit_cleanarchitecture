import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_course/domain/entities/advice_entity.dart';
import 'package:flutter_bloc_course/domain/failures/failure.dart';

class AdviceUseCase {
  Future<Either<Failure, AdviceEntity>> getAdvoce() async {
    await Future.delayed(const Duration(seconds: 3));

    // return right(const AdviceEntity(id: 1, advice: "Hello from my heart"));
    return left(ServerFailure());
  }
}
