import 'package:blog_app/features/auth/domain/usecase/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  AuthBloc({required UserSignup userSignup})
    : _userSignup = userSignup,
      super(AuthInitial()) {
    on<AuthSignup>((event, emit) async {
      final res = await _userSignup(
        UserSignupParams(event.name, event.email, event.password),
      );
      print('Use case result received: $event.name');
      res.fold(
        (l) => (AuthFailureState(l.message)),
        (r) => (AuthSuccessState()),
      );
    });
  }
}
