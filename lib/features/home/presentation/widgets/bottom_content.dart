import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather/features/home/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/home/presentation/widgets/block_container.dart';

class BottomContent extends StatelessWidget {
  const BottomContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeWeather =
        context.select((WeatherBloc bloc) => bloc.state.activeWeather);
    return BlockContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _BottomContentItem(
              imageFileName: 'wind.png',
              leftText: '${activeWeather.windSpeed} м/с',
              rightText: 'Ветер ${activeWeather.windDescription}',
            ),
            const SizedBox(height: 16),
            _BottomContentItem(
              imageFileName: 'drop.png',
              leftText: '${activeWeather.humidity}%',
              rightText: '${activeWeather.humidityDescription} влажность',
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomContentItem extends StatelessWidget {
  final String imageFileName;
  final String leftText;
  final String rightText;

  const _BottomContentItem({
    Key? key,
    required this.imageFileName,
    required this.leftText,
    required this.rightText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Image.asset(
          'assets/images/icons/$imageFileName',
          height: 24,
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 60,
          child: Text(
            leftText,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
        ),
        const SizedBox(width: 24),
        Text(
          rightText,
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
