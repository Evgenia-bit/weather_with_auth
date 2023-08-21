import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/styles/theme.dart';
import 'package:weather/features/home/presentation/home_screen.dart';
import 'package:weather/features/login/presentation/login_screen.dart';
import 'package:weather/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:weather/features/splash/presentation/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: createTheme(),
      routes: {
        '/home': (_) => const HomeScreen(),
        '/login': (_) => const LoginScreen(),
      },
      home: BlocProvider(
        create: (_) => SplashBloc(),
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (_, state) {
            if (state is SplashLoading) {
              return const SplashScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
