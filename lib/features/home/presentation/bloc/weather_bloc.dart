import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather/features/home/data/data_sources/weather_remote_data_source.dart';
import 'package:weather/features/home/domain/entity/location.dart';
import 'package:weather/features/home/domain/repository/weather_repository.dart';
import 'package:weather/features/home/domain/entity/weather.dart';

part 'weather_state.dart';

class WeatherBloc extends Cubit<WeatherState> {
  WeatherBloc(this._weatherRepository) : super(WeatherState()) {
    getWeather();
  }

  final WeatherRepository _weatherRepository;

  Future<void> getWeather() async {
    try {
      final (weather, location) = await _weatherRepository.getCurrentWeather();
      emit(state.copyWith(forecast: [weather], location: location));

      final forecast = await _weatherRepository.getForecast();
      emit(state.copyWith(forecast: [...state.forecast, ...forecast]));

    } on WeatherException catch (e) {
      emit(state.copyWith(errorMessage: e.message));
    } catch (e) {
      if (e is DioException && e.error is SocketException) {
        emit(state.copyWith(
          errorMessage: 'Отсутствует подключение к интернету',
        ));
        return;
      }
      emit(state.copyWith(errorMessage: 'Произошла неизвестная ошибка'));
    }
  }

  void changeActiveWeather(int index) {
    emit(state.copyWith(activeWeatherIndex: index));
  }
}
