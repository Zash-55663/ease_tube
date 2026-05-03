import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ease_tube/data/response/api_response.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'login_events.dart';
part 'login_states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginBloc() : super(const LoginStates()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_onFormSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginStates> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginStates> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<LoginStates> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> _onFormSubmitted(
    LoginApi event,
    Emitter<LoginStates> emit,
  ) async {
    debugPrint("BLOC: Starting Login Process for ${state.email}");
    emit(state.copyWith(loginApi: ApiResponse.loading()));

    try {
      // Firebase Auth call
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: state.email.trim(),
        password: state.password.trim(),
      );

      // If successful, emit completed
      emit(state.copyWith(loginApi: ApiResponse.completed('Login successful')));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(loginApi: ApiResponse.error(e.message.toString())));
    } catch (e) {
      debugPrint("BLOC: Error: $e"); // <--- Add this
      emit(state.copyWith(loginApi: ApiResponse.error(e.toString())));
    }
  }
}
