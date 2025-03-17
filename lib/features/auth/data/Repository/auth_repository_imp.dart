// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/core/error/exception.dart';

import 'package:blog_app/core/error/failure.dart';

import 'package:blog_app/features/auth/data/remoteDataSource/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

//this section will interact betwween remote dataabase and domain Repository section

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required email,
    required password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required name,
    required email,
    required password,
  }) async {
    try {
      final userId = await remoteDatasource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
