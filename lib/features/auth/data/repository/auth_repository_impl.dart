import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ConnectionChecker connectionChecker;
  AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      if (await connectionChecker.isConnected == false) {
        final session = remoteDataSource.currentSession;
        if (session == null) {
          return left(Failure("No internet connection and no session found"));
        }
        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? "",
            name: "",
          ),
        );
      }
      final userData = await remoteDataSource.getCurrentUser();
      if (userData == null) return left(Failure("No user found"));
      return right(userData);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (await connectionChecker.isConnected == false) {
        return left(Failure("No internet connection"));
      }
      final user = await remoteDataSource.logInWithEmailPassword(
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      if (await connectionChecker.isConnected == false) {
        return left(Failure("No internet connection"));
      }
      final user = await remoteDataSource.signUpWithEmailPassword(
        email: email,
        name: name,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
