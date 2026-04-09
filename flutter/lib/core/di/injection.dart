import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../constants/app_constants.dart';
import '../network/api_client.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/trainer/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/trainer/students/presentation/bloc/students_bloc.dart';
import '../../features/trainer/workouts/presentation/bloc/workout_builder_bloc.dart';
import '../../features/aluno/home/presentation/bloc/aluno_home_bloc.dart';
import '../../features/aluno/session/presentation/bloc/session_bloc.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  // ── Infraestrutura ─────────────────────────────────────────────
  const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
  sl.registerSingleton<FlutterSecureStorage>(storage);

  final apiClient = ApiClient(storage);
  sl.registerSingleton<ApiClient>(apiClient);
  sl.registerSingleton<Dio>(apiClient.instance);

  // ── Auth ────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDatasource>(), sl<FlutterSecureStorage>()),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(repository: sl<AuthRepository>()),
  );

  // ── Trainer ─────────────────────────────────────────────────────
  sl.registerFactory<DashboardBloc>(() => DashboardBloc(sl<Dio>()));
  sl.registerFactory<StudentsBloc>(() => StudentsBloc(sl<Dio>()));
  sl.registerFactory<WorkoutBuilderBloc>(() => WorkoutBuilderBloc(sl<Dio>()));

  // ── Aluno ───────────────────────────────────────────────────────
  sl.registerFactory<AlunoHomeBloc>(() => AlunoHomeBloc(sl<Dio>()));
  sl.registerFactory<SessionBloc>(() => SessionBloc(sl<Dio>()));
}
