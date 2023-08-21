import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto/crypto.dart';

import 'package:weather/features/login/domain/repository/login_repository.dart';

part 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc(this._loginRepository) : super(const LoginState());

  final LoginRepository _loginRepository;

  void changeEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void changePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void changeShowPassword() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  Future<void> submitForm() async {
    if (state.formSubmittionStatus == FormSubmittionStatus.inProgress) return;

    final email = state.email;
    final password = state.password;

    if (!isValidEmail(email) || !isValidPassword(password)) {
      emit(state.copyWith(formSubmittionStatus: FormSubmittionStatus.failed));
      return;
    }

    emit(state.copyWith(
      formSubmittionStatus: FormSubmittionStatus.inProgress,
    ));

    try {
      final hashPassword = _hashPassword(password).toString();
      await _loginRepository.signIn(email: email, password: hashPassword);
      emit(
        state.copyWith(formSubmittionStatus: FormSubmittionStatus.success),
      );
    } on FirebaseAuthException catch (e) {
      final errorMessage = _handleFirebaseError(e.code);

      emit(state.copyWith(
        formSubmittionStatus: FormSubmittionStatus.failed,
        errorMessage: errorMessage,
      ));
    } catch (e) {
      emit(state.copyWith(
        formSubmittionStatus: FormSubmittionStatus.failed,
        errorMessage: 'Произошла неизвестная ошибка',
      ));
    }
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}');
    return passwordRegExp.hasMatch(password);
  }

  String _handleFirebaseError(String code) {
    return switch (code) {
      "invalid-email" =>'Данный email не валиден',
      "email-already-in-use" => 'Данный email уже используется',
      "user-disabled" => 'Пользователь заблокирован',
      "wrong-password" => 'Неверный пароль',
      "operation-not-allowed" =>
      "Ошибка сервера, пожалуйста, повторите попытку позже",
      "network-request-failed" => "Нет подключения к интернету",
      _ =>'Ошибка входа. Пожалуйста, попробуйте снова.'
    };
  }

  Digest _hashPassword(String password) {
    var bytes = utf8.encode(password); // data being hashed
    return sha512.convert(bytes);
  }
}
