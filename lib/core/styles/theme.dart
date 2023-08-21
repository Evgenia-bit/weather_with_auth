import 'package:flutter/material.dart';
import 'package:weather/core/styles/colors.dart';

ThemeData createTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.blue,
    useMaterial3: true,
    textTheme: createTextTheme(),
  );
}

TextTheme createTextTheme() {
  return const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w500,
      fontSize: 64,
      height: 1.2,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
      fontSize: 48,
      height: 1.2,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w300,
      fontSize: 24,
      height: 1.2,
      color: Colors.white,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w500,
      fontSize: 28,
      height: 1.2,
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w500,
      fontSize: 22,
      height: 1.2,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 17,
      height: 1.2,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 15,
      height: 1.2,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 13,
      height: 1.2,
    ),
  );
}
