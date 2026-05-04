import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:ease_tube/data/response/api_response.dart';
import 'package:equatable/equatable.dart';

// These 'part' directives link the files together.
// Ensure login_events.dart and login_states.dart have 'part of login_bloc.dart' at the top.
part 'login_events.dart';
part 'login_states.dart';

/// The Business Logic Component (Bloc) responsible for managing authentication state.
/// It coordinates user input from the UI and communicates with Firebase Auth.
class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc() : super(const LoginStates()) {
    // Mapping events to their respective handler functions
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_onFormSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  /// Toggles the boolean state to show or hide the password in the UI.
  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<LoginStates> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  /// Updates the email string in the state as the user types.
  void _onEmailChanged(EmailChanged event, Emitter<LoginStates> emit) {
    emit(state.copyWith(email: event.email));
  }

  /// Updates the password string in the state as the user types.
  void _onPasswordChanged(PasswordChanged event, Emitter<LoginStates> emit) {
    emit(state.copyWith(password: event.password));
  }

  /// Handles the actual authentication process with Firebase.
  Future<void> _onFormSubmitted(
    LoginApi event,
    Emitter<LoginStates> emit,
  ) async {
    // 1. Set status to loading to trigger the LoadingWidget in the UI.
    emit(state.copyWith(loginApi: const ApiResponse.loading()));

    try {
      // 2. Attempt to sign in with Firebase using trimmed inputs to prevent whitespace errors.
      await _auth.signInWithEmailAndPassword(
        email: state.email.trim(),
        password: state.password.trim(),
      );

      // 3. On success, emit the completed state.
      emit(
        state.copyWith(loginApi: const ApiResponse.completed('LOGIN_SUCCESS')),
      );
    } on FirebaseAuthException catch (e) {
      // 4. Handle specific Firebase errors (e.g., wrong password, user not found).
      // We use e.message for a cleaner user-facing error message.
      emit(
        state.copyWith(
          loginApi: ApiResponse.error(e.message ?? "Authentication Failed"),
        ),
      );
    } catch (e) {
      // 5. Catch-all for unexpected errors (e.g., network issues or timeouts).
      emit(
        state.copyWith(
          loginApi: ApiResponse.error("An unexpected error occurred"),
        ),
      );
    }
  }
}
