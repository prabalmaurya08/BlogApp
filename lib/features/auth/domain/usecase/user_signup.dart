// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements Usecase<User, UserSignupParams> {
  final AuthRepository authRepository;
  UserSignup({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignupParams {
  final String name;
  final String email;
  final String password;

  UserSignupParams(this.name, this.email, this.password);
}
