import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/home/domain/entity/weather.dart';
import 'package:weather/features/home/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/home/presentation/widgets/block_container.dart';

class ForecastListContainer extends StatelessWidget {
  const ForecastListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BlockContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Header(),
          Divider(color: Colors.white),
          _Content(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final (dayName, date) = context.select(
      (WeatherBloc bloc) => (
        bloc.state.activeWeather.dayName,
        bloc.state.activeWeather.date,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dayName ?? '',
            style: textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
          Text(
            date ?? '',
            style: textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final (forecast, activeWeatherIndex) = context.select(
      (WeatherBloc bloc) => (
        bloc.state.forecast,
        bloc.state.activeWeatherIndex,
      ),
    );
    final List<Widget> forecastWidgetsList = [];

    for (var i = 0; i < forecast.length; i++) {
      forecastWidgetsList.add(
        _ForecastItem(
          index: i,
          weather: forecast[i],
          isActive: i == activeWeatherIndex,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      height: 175,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: forecastWidgetsList,
      ),
    );
  }
}

class _ForecastItem extends StatelessWidget {
  final bool isActive;
  final int index;
  final Weather weather;

  const _ForecastItem({
    Key? key,
    this.isActive = false,
    required this.index,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final imagePath =
        'assets/images/small_weather/${weather.type.imageFileName}';

    BoxDecoration? decoration;
    if (isActive) {
      decoration = BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      );
    }

    return InkWell(
      onTap: () {
        context.read<WeatherBloc>().changeActiveWeather(index);
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: decoration,
        child: Column(
          children: [
            Text(
              weather.time ?? '',
              style: textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 16),
            Image.asset(imagePath, height: 32),
            const SizedBox(height: 16),
            Text(
              weather.temp.toString(),
              style: textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
