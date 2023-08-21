import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather/core/styles/colors.dart';
import 'package:weather/features/home/domain/repository/weather_repository.dart';
import 'package:weather/features/home/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/home/presentation/widgets/bottom_content.dart';
import 'package:weather/features/home/presentation/widgets/forecast_list_container.dart';
import 'package:weather/features/home/presentation/widgets/top_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(),
      child: Builder(builder: (context) {
        return BlocProvider(
          create: (context) {
            final repository =
                RepositoryProvider.of<WeatherRepository>(context);
            return WeatherBloc(repository);
          },
          child: Scaffold(
            body: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.blue.withOpacity(0.66), Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const SafeArea(
                child: _Body(),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final (isLoading, errorMessage) = context.select(
        (WeatherBloc bloc) => (bloc.state.isLoading, bloc.state.errorMessage));

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final Widget child;
    if (errorMessage.isNotEmpty) {
      child = const _Error();
    } else {
      child = const _Content();
    }

    return RefreshIndicator(
      onRefresh: context.read<WeatherBloc>().getWeather,
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: child,
          )
        ],
      ),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final errorMessage = context.select(
      (WeatherBloc bloc) => bloc.state.errorMessage,
    );

    return Center(
      child: Text(
        errorMessage,
        textAlign: TextAlign.center,
        style: textTheme.headlineMedium?.copyWith(color: Colors.white),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TopContent(),
        SizedBox(height: 24),
        ForecastListContainer(),
        SizedBox(height: 24),
        BottomContent(),
      ],
    );
  }
}
