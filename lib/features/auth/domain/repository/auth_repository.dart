import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String email,
    required String name,
    required String password,
  });
  Future<Either<Failure, User>> logInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> getCurrentUser();
}
