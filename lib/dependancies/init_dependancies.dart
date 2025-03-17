import 'dart:ffi';

import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/Repository/auth_repository_imp.dart';
import 'package:blog_app/features/auth/data/remoteDataSource/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecase/user_signup.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<Void> initDependancy() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(remoteDatasource: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => UserSignup(authRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(userSignup: serviceLocator()),
  );
}
