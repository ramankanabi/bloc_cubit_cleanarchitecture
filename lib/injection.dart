import 'package:flutter_bloc_course/0_data/datasources/advice_remote_datasource.dart';
import 'package:flutter_bloc_course/0_data/repositories/advice_repo_impl.dart';
import 'package:flutter_bloc_course/1_domain/repositories/advice_repository.dart';
import 'package:flutter_bloc_course/1_domain/usecases/advice_usecase.dart';
import 'package:flutter_bloc_course/2_app/pages/advicePage/cubit/advice_cubit.dart';
import 'package:get_it/get_it.dart';
import "package:http/http.dart" as http;

final sl = GetIt.I; // sl==Service Locator

Future<void> inti() async {
// Factory = every time a new/fresh instance of that class

  // ! application layer
  sl.registerFactory(() => AdviceCubit(adviceUsecase: sl()));

  // ! domain layer
  sl.registerFactory(() => AdviceUseCase(adviceRepo: sl()));

  // ! data layer
  sl.registerFactory<AdviceRepo>(
      () => AdviceRepoImpl(adviceRemoteDatasource: sl()));
  sl.registerFactory<AdviceRemoteDataSource>(
      () => AdviceRemoteDataSourceImpl(client: sl()));

  // ! externs
  sl.registerFactory(() => http.Client());
}
