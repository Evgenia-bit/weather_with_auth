import 'package:flutter/material.dart';
import 'package:weather/core/styles/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 43.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.blue,
              Colors.black,
            ],
          ),
        ),
        child:  Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'WEATHER \nSERVICE',
                  style: textTheme.displayMedium,
                ),
              ),
            ),
            Text(
              'dawn is coming soon',
              style: textTheme.displaySmall,
            ),
            const SizedBox(height: 86),
          ],
        ),
      ),
    );
  }
}
