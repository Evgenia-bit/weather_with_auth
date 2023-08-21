import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather/core/styles/colors.dart';
import 'package:weather/features/login/domain/repository/login_repository.dart';
import 'package:weather/features/login/presentation/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 48,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(),
              _Form(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          'Вход',
          style: textTheme.headlineLarge,
        ),
        const SizedBox(height: 12),
        Text(
          'Введите данные для входа ',
          style: textTheme.bodyMedium?.copyWith(color: AppColors.grey),
        ),
      ],
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => LoginRepository(),
      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (_) {
              final repository = RepositoryProvider.of<LoginRepository>(context);
              return LoginBloc(repository);
            },
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.formSubmittionStatus == FormSubmittionStatus.failed &&
                    state.errorMessage.isNotEmpty) {
                  showDialog<void>(
                    context: context,
                    builder: (_) =>
                        AlertDialog(
                          title: const Text('Произошла ошибка'),
                          content: Text(state.errorMessage),
                        ),
                  );
                }
                if (state.formSubmittionStatus ==
                    FormSubmittionStatus.success) {
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              },
              child: const Column(
                children: <Widget>[
                  _EmailInput(),
                  SizedBox(height: 24),
                  _PasswordInput(),
                  SizedBox(height: 48),
                  _SubmitButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    final (email, formSubmittionStatus) = context.select(
    (LoginBloc loginBloc) => (
    loginBloc.state.email,
    loginBloc.state.formSubmittionStatus,
    ),
    );
    String? errorText;
    if (formSubmittionStatus == FormSubmittionStatus.failed &&
    !bloc.isValidEmail(email)) {
    errorText = 'Пожалуйста, убедитесь, что email введен правильно';
    }

    return _Input(
    initialValue: email,
    labelText: 'Email',
    errorText: errorText,
    onChange: bloc.changeEmail,
    textInputAction: TextInputAction.next,
    keyboardType:
    TextInputType
    .
    emailAddress
    ,
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    final (password, formSubmittionStatus, showPassword) = context.select(
    (LoginBloc loginBloc) => (
    loginBloc.state.password,
    loginBloc.state.formSubmittionStatus,
    loginBloc.state.showPassword,
    ),
    );
    final suffixImageFileName =
    showPassword ? 'open_eye.png' : 'closed_eye.png';
    String? errorText;
    if (formSubmittionStatus == FormSubmittionStatus.failed &&
    !bloc.isValidPassword(password)) {
    errorText =
    'Пароль должен содержать не менее 8 символов, как минимум одну цифру и букву верхнего и нижнего регистра';
    }

    return _Input(
    initialValue: password,
    labelText: 'Пароль',
    errorText: errorText,
    onChange: bloc.changePassword,
    textInputAction: TextInputAction.done,
    keyboardType: TextInputType.visiblePassword,
    obscureText: !showPassword,
    suffix: IconButton(
    icon: Image.asset(
    'assets/images/icons/$suffixImageFileName',
    fit: BoxFit.cover,
    height: 30,
    ),
    padding: const EdgeInsets.all(0),
    onPressed: bloc
    .
    changeShowPassword
    ,
    )
    ,
    );
  }
}

class _Input extends StatelessWidget {
  final String initialValue;
  final String labelText;
  final String? errorText;
  final Function(String) onChange;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final Widget? suffix;
  final bool obscureText;

  const _Input({
    Key? key,
    required this.initialValue,
    required this.labelText,
    required this.errorText,
    required this.onChange,
    required this.keyboardType,
    required this.textInputAction,
    this.suffix,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        suffixIcon: suffix,
        labelText: labelText,
        errorMaxLines: 3,
        errorText: errorText,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.textFieldFocusedBorderColor,
            width: 2,
          ),
        ),
        labelStyle: textTheme.bodyLarge?.copyWith(color: AppColors.grey),
      ),
      obscureText: obscureText,
      onChanged: onChange,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    final bloc = context.read<LoginBloc>();
    final (isValid, formSubmittionStatus) = context.select(
    (LoginBloc loginBloc) => (
    loginBloc.state.isValid,
    loginBloc.state.formSubmittionStatus,
    ),
    );

    return SizedBox(
    width: double.infinity,
    height: 48,
    child: ElevatedButton(
    style: const ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(AppColors.blue),
    ),
    onPressed: isValid ? () => bloc.submitForm() : null,
    child: formSubmittionStatus == FormSubmittionStatus.inProgress
    ? const Center(
    child: CircularProgressIndicator(
    color: Colors.white,
    ),
    )
        : Text(
    'Войти',
    style: textTheme.bodyMedium?.copyWith(color: Colors.white),
    ),
    ),
    );
  }
}
