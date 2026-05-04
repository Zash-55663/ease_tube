part of 'login_bloc.dart'; // Links this file to the main Bloc file

/// Abstract base for all login-related actions.
/// Sealed to ensure exhaustive event handling within the Bloc.
sealed class LoginEvents extends Equatable {
  const LoginEvents();
  @override
  List<Object> get props => [];
}

/// Triggered whenever the user types in the email field.
class EmailChanged extends LoginEvents {
  final String email;
  const EmailChanged({required this.email});

  @override
  List<Object> get props => [email]; // Fixed: Included email in props for comparison
}

/// Triggered whenever the user types in the password field.
class PasswordChanged extends LoginEvents {
  final String password;
  const PasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

/// Triggered when the user taps the 'Login' RoundButton.
/// This will initiate the call to NetworkApiService.
class LoginApi extends LoginEvents {
  const LoginApi();
}

/// Triggered to switch the obscureText property of the password field.
class TogglePasswordVisibility extends LoginEvents {}
