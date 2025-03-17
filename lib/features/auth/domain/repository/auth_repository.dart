import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required name,
    required email,
    required password,
  });
  Future<Either<Failure, String>> loginWithEmailPassword({
    required email,
    required password,
  });
}
