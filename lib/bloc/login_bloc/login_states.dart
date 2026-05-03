part of 'login_bloc.dart';

class LoginStates extends Equatable {
  const LoginStates({
    this.email = '',
    this.password = '',
    this.loginApi = const ApiResponse.completed(''),
    this.isPasswordVisible = false,
  });

  final String email;
  final String password;
  final ApiResponse<String> loginApi;
  final bool isPasswordVisible;

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
  List<Object> get props => [email, password, loginApi, isPasswordVisible];
}
