import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/core/error/failure.dart';
import 'package:blog_app/features/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements Usecase<String, UserSignupParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, String>> call(UserSignupParams params) async {
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
