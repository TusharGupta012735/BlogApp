import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentSession;
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String name,
    required String password,
  });
  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUser();
}

//datasources in data file
class AuthRemoteDataSourceimpl extends AuthRemoteDataSource {
  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceimpl(this.supabaseClient);

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (currentSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select("*")
            .eq("id", currentSession!.user.id);
        return UserModel.fromJson(userData.first);
      }
      //.from is used to contact directly with the table in supabase instead of auth
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      return response.user != null
          ? UserModel.fromJson(response.user!.toJson())
          : throw ServerException("User is null ");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
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
          // we pass the user data as a json file and inside the user model defined we parse a usermodel from that json
          ? UserModel.fromJson(response.user!.toJson())
          : throw ServerException("User is null ");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
