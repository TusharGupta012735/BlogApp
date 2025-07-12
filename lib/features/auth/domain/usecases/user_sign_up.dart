import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements Usecase<User, UserSignupParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async {
    return await authRepository.signUpWithEmailPassword(
      email: params.email,
      name: params.name,
      password: params.password,
    );
  }
}

class UserSignupParams {
  final String name;
  final String email;
  final String password;

  UserSignupParams({
    required this.email,
    required this.name,
    required this.password,
  });
}

