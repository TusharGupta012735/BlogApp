import 'package:blog_app/features/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required String email,
    required String name,
    required String password,
  });
  Future<String> logInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceimpl extends AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceimpl(this.supabaseClient);

  @override
  Future<String> logInWithEmailPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );

      return response.user != null
          ? response.user!.id
          : throw ServerException("User is null ");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
