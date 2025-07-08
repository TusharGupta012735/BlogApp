import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String email,
    required String name,
    required String password,
  });
  Future<Either<Failure, String>> logInWithEmailPassword({
    required String email,
    required String password,
  });
}
