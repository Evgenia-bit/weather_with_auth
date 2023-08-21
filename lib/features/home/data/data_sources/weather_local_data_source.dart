import 'package:weather/features/home/data/DTO/location_DTO.dart';
import 'package:weather/features/home/data/DTO/weather_DTO.dart';
import 'package:weather/features/home/data/data_sources/abstract_weather_data_source.dart';
import 'package:hive/hive.dart';

const forecastBoxName = 'forecast_box';
const locationBoxName = 'location_box';

class WeatherLocalDataSource extends AbstractWeatherDataSource {
  final _locationBox = Hive.openBox<LocationDTO>(locationBoxName);
  final _weatherBox = Hive.openBox<WeatherDTO>(forecastBoxName);

  @override
  Future<(WeatherDTO?, LocationDTO?)> getCurrentWeather() async {
    final weatherValues = (await _weatherBox).values;
    final weather = weatherValues.isEmpty ? null : weatherValues.first;
    final locationValues = (await _locationBox).values;
    final location =
        locationValues.isEmpty ? null : (await _locationBox).values.first;
    return (weather, location);
  }

  @override
  Future<List<WeatherDTO>> getForecast() async {
    return (await _weatherBox).values.toList();
  }

  Future<void> putAllWeather(List<WeatherDTO> forecast) async {
    final weathersMap = {for (var w in forecast) w.dateTime: w};
    await (await _weatherBox).putAll(weathersMap);
  }

  Future<void> putWeather(WeatherDTO weather) async {
    await (await _weatherBox).put(weather.dateTime, weather);
  }

  Future<void> putLocation(LocationDTO location) async {
    await (await _locationBox).put(location.city, location);
  }
}
