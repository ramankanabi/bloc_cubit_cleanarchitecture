import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_course/0_data/datasources/advice_remote_datasource.dart';
import 'package:flutter_bloc_course/0_data/exceptions/exceptions.dart';
import 'package:flutter_bloc_course/1_domain/entities/advice_entity.dart';
import 'package:flutter_bloc_course/1_domain/failures/failure.dart';
import 'package:flutter_bloc_course/1_domain/repositories/advice_repository.dart';

class AdviceRepoImpl implements AdviceRepo {
  final AdviceRemoteDataSource adviceRemoteDatasource =
      AdviceRemoteDataSourceImpl();
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    try {
      final result = await adviceRemoteDatasource.getRandomAdviceFromapi();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
