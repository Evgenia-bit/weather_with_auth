part of 'splash_bloc.dart';

sealed class SplashState {
  const SplashState();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashLoaded extends SplashState {
  const SplashLoaded();
}
