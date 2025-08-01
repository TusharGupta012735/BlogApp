import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app/core/common/entities/user.dart' as myUser;
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  }) : _userSignUp = userSignUp,
       _userSignIn = userSignIn,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_authSignUp);
    on<AuthSignIn>(_authSignIn);
    on<AuthIsUserLoggedIn>(_authIsUserLoggedIn);
  }

  void _authIsUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());
    res.fold(
      (l) {
        emit(AuthFailure(l.message));
      },
      (r) {
        _emitAuthSuccess(r, emit);
      },
    );
  }

  void _authSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final res = await _userSignIn(
      UserSignInParams(email: event.email, password: event.password),
    );
    res.fold(
      (l) {
        emit(AuthFailure(l.message));
      },
      (r) {
        _emitAuthSuccess(r, emit);
      },
    );
  }

  void _authSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    // emit(
    //   AuthLoading(),
    // ); //emits a new state for the app while doing signup in background
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
        _emitAuthSuccess(r, emit);
      },
    );
  }

  void _emitAuthSuccess(myUser.User user, Emitter<AuthState> emit) {
    emit(AuthSuccess(user));
    _appUserCubit.updateUser(user);
  }
}
