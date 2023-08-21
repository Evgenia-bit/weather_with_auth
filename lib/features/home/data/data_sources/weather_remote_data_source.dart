import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';

import 'package:weather/core/configiration/api_configuration.dart';
import 'package:weather/features/home/data/DTO/location_DTO.dart';
import 'package:weather/features/home/data/DTO/weather_DTO.dart';
import 'package:weather/features/home/data/data_sources/abstract_weather_data_source.dart';

class WeatherRemoteDataSource extends AbstractWeatherDataSource {
  final _dio = Dio();
  Position? _position;

  @override
  Future<(WeatherDTO, LocationDTO)> getCurrentWeather() async {
    final result = await _get("weather");
    final weather = WeatherDTO.fromJson(result);
    final location = LocationDTO.fromJson(result);
    return (weather, location);
  }

  @override
  Future<List<WeatherDTO>> getForecast() async {
    final result = await _get("forecast");

    final forecast = result['list']
        .map<WeatherDTO>((json) => WeatherDTO.fromJson(json))
        .toList() as List<WeatherDTO>;

    return forecast;
  }

  Future<Map<String, dynamic>> _get(String path) async {
    _position ??= await _getPosition();
    final response = await _dio.get(
      '${ApiConfiguration.host}/$path',
      queryParameters: {
        'lat': _position?.latitude,
        'lon': _position?.longitude,
        'units': 'metric',
        'APPID': ApiConfiguration.apiKey,
      },
    );
    _handleResponse(response);
    return response.data;
  }

  Future<Position> _getPosition() async {
    try {
      await Geolocator.requestPermission();
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      throw GetPositionFailed();
    }
  }

  void _handleResponse(Response response) {
    final code = response.statusCode;
    return switch (code) {
      401 => throw Unauthorized(),
      404 => throw NotFound(),
      429 => throw TooManyRequests(),
      500 => throw ServerError(),
      _ => null,
    };
  }
}

sealed class WeatherException {
  abstract String message;
}

class GetPositionFailed extends WeatherException {
  @override
  String message = 'Не удалось получить геолокацию';
}

class Unauthorized extends WeatherException {
  @override
  String message = 'Неавторизованный запрос';
}

class NotFound extends WeatherException {
  @override
  String message = 'Погода по данному запросу не найдена';
}

class TooManyRequests extends WeatherException {
  @override
  String message = 'Слишком много запросов. Попробуйте позже';
}

class ServerError extends WeatherException {
  @override
  String message = 'Произошла ошибка сервера. Попробуйте позже';
}
