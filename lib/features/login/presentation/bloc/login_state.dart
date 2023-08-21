part of 'login_bloc.dart';

final class LoginState {
  const LoginState({
    this.email = '',
    this.password = '',
    this.showPassword = false,
    this.formSubmittionStatus = FormSubmittionStatus.initial,
    this.errorMessage = '',
  });

  final String email;
  final String password;
  final bool showPassword;
  final FormSubmittionStatus formSubmittionStatus;
  final String errorMessage;
  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  LoginState copyWith({
    String? email,
    String? password,
    bool? showPassword,
    FormSubmittionStatus? formSubmittionStatus,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formSubmittionStatus: formSubmittionStatus ?? this.formSubmittionStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}

enum FormSubmittionStatus { initial, failed, success, inProgress }
