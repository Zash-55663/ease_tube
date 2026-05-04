part of 'login_bloc.dart'; // Links this file to the main Bloc file

/// Represents the state of the login process, including user inputs and API status.
class LoginStates extends Equatable {
  const LoginStates({
    this.email = '',
    this.password = '',
    // Initializing with an empty completed state or 'loading' depending on your flow
    this.loginApi = const ApiResponse.completed(''),
    this.isPasswordVisible = false,
  });

  // User input fields
  final String email;
  final String password;

  // Encapsulated API response using the generic ApiResponse wrapper
  final ApiResponse<String> loginApi;

  // UI state for toggling password obscured text
  final bool isPasswordVisible;

  /// Creates a new state instance by copying existing values and overriding specified ones.
  LoginStates copyWith({
    String? email,
    String? password,
    ApiResponse<String>? loginApi,
    bool? isPasswordVisible,
  }) {
    return LoginStates(
      email: email ?? this.email,
      password: password ?? this.password,
      loginApi: loginApi ?? this.loginApi,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  @override
  // Registering properties for value-based comparison
  List<Object> get props => [email, password, loginApi, isPasswordVisible];
}
