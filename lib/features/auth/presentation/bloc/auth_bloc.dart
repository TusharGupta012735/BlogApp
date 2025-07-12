import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart' as myUser;
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  AuthBloc({required UserSignUp userSignUp, required UserSignIn userSignIn})
    : _userSignUp = userSignUp,
      _userSignIn = userSignIn,

      super(AuthInitial()) {
    on<AuthSignUp>(_authSignUp);
    on<AuthSignIn>(_authSignIn);
  }

  void _authSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignIn(
      UserSignInParams(email: event.email, password: event.password),
    );
    res.fold(
      (l) {
        emit(AuthFailure(l.message));
      },
      (r) {
        emit(AuthSuccess(r));
      },
    );
  }

  void _authSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(
      AuthLoading(),
    ); //emits a new state for the app while doing signup in background
    final res = await _userSignUp(
      UserSignupParams(
        email: event.email,
        name: event.name,
        password: event.password,
      ),
    );
    res.fold(
      (l) {
        emit(AuthFailure(l.message));
      },
      (r) {
        emit(AuthSuccess(r));
      },
    );
  }
}
