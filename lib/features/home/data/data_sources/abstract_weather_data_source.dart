import 'package:weather/features/home/data/DTO/location_DTO.dart';
import 'package:weather/features/home/data/DTO/weather_DTO.dart';

abstract class AbstractWeatherDataSource {
  Future<(WeatherDTO?, LocationDTO?)> getCurrentWeather();

  Future<List<WeatherDTO>> getForecast();
}
