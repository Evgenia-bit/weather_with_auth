import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/home/presentation/bloc/weather_bloc.dart';

class TopContent extends StatelessWidget {
  const TopContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _LocationRow(),
        SizedBox(height: 24),
        _Image(),
        _Temp(),
        _WeatherType(),
        SizedBox(height: 8),
        _MaxMinTemp(),
      ],
    );
  }
}

class _LocationRow extends StatelessWidget {
  const _LocationRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final location =
        context.select((WeatherBloc weatherBloc) => weatherBloc.state.location);

    return Row(
      children: [
        Image.asset('assets/images/icons/location.png', height: 24),
        const SizedBox(width: 8),
        Text(
          '${location?.city}, ${location?.country}',
          style: textTheme.bodyMedium?.copyWith(color: Colors.white),
        )
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageFileName = context.select(
      (WeatherBloc weatherBloc) =>
          weatherBloc.state.activeWeather.type.imageFileName,
    );
    final imagePath = 'assets/images/big_weather/$imageFileName';

    return SizedBox(
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/images/big_weather/shadow.png'),
          Image.asset(imagePath),
        ],
      ),
    );
  }
}

class _Temp extends StatelessWidget {
  const _Temp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final temp = context.select(
      (WeatherBloc weatherBloc) => weatherBloc.state.activeWeather.temp,
    );

    return Text(
      '$tempº',
      style: textTheme.displayLarge,
    );
  }
}

class _WeatherType extends StatelessWidget {
  const _WeatherType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final label = context.select(
      (WeatherBloc weatherBloc) => weatherBloc.state.activeWeather.type.label,
    );

    return Text(
      label,
      style: textTheme.bodyLarge?.copyWith(color: Colors.white),
    );
  }
}

class _MaxMinTemp extends StatelessWidget {
  const _MaxMinTemp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final (maxTemp, minTemp) = context.select(
      (WeatherBloc weatherBloc) => (
        weatherBloc.state.activeWeather.maxTemp,
        weatherBloc.state.activeWeather.minTemp
      ),
    );

    return Text(
      'Макс.: $maxTempº Мин: $minTempº',
      style: textTheme.bodyLarge?.copyWith(color: Colors.white),
    );
  }
}
