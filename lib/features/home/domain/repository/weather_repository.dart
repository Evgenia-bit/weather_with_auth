import 'dart:io';
import 'package:dio/dio.dart';

import 'package:weather/features/home/data/DTO/location_DTO.dart';
import 'package:weather/features/home/data/DTO/weather_DTO.dart';
import 'package:weather/features/home/data/data_sources/weather_local_data_source.dart';
import 'package:weather/features/home/data/data_sources/weather_remote_data_source.dart';
import 'package:weather/features/home/domain/entity/location.dart';
import 'package:weather/features/home/domain/entity/weather.dart';
import 'package:weather/features/home/domain/mappers/location_mapper.dart';
import 'package:weather/features/home/domain/mappers/weather_mapper.dart';

class WeatherRepository {
  final _remoteSource = WeatherRemoteDataSource();
  final _localSource = WeatherLocalDataSource();
  final _weatherMapper = WeatherMapper();
  final _locationMapper = LocationMapper();

  Future<(Weather, Location)>

  getCurrentWeather() async {
    late WeatherDTO? weatherDTO;
    late LocationDTO? locationDTO;
    try {
      (weatherDTO, locationDTO) = await _remoteSource.getCurrentWeather();
      await _localSource.putWeather(weatherDTO);
      await _localSource.putLocation(locationDTO);
    } catch (e) {
      if (e is DioException && e.error is SocketException) {
        (weatherDTO, locationDTO) = await _localSource.getCurrentWeather();
        if (weatherDTO == null || locationDTO == null) rethrow;
      } else {
        rethrow;
      }
    }

    final weather = await _weatherMapper.from(weatherDTO);
    final location = await _locationMapper.from(locationDTO);

    return (weather, location);
  }

  Future<List<Weather>> getForecast() async {
    late List<WeatherDTO> weatherDTOList;
    try {
      weatherDTOList = await _remoteSource.getForecast();
      await _localSource.putAllWeather(weatherDTOList);
    } catch (e) {
      if (e is DioException && e.error is SocketException) {
        weatherDTOList = await _localSource.getForecast();
        if (weatherDTOList.isEmpty) rethrow;
      } else {
        rethrow;
      }
    }

    final forecast = [
      for (final item in weatherDTOList) await _weatherMapper.from(item)
    ];

    return forecast;
  }
}
