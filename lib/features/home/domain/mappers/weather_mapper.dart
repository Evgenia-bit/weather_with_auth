import 'package:weather/core/utils/translator.dart';
import 'package:weather/features/home/data/DTO/weather_DTO.dart';
import 'package:weather/features/home/domain/entity/weather.dart';
import 'package:intl/intl.dart';

class WeatherMapper {
  final Map<bool Function(num), String> _humidityDescriptionMap = {
    (h) => 65 <= h: 'Высокая',
    (h) => 30 <= h && h <= 65: 'Нормальная',
    (h) => h <= 30: 'Низкая',
  };

  final Map<bool Function(num), String> _windDescriptionMap = {
    (deg) => (348.75 < deg || deg <= 11.25): 'северный',
    (deg) => (11.25 < deg && deg <= 78.75): 'северо-восточный',
    (deg) => (78.75 < deg && deg <= 101.25): 'восточный',
    (deg) => (101.25 < deg && deg <= 168.75): 'юго-восточный',
    (deg) => (168.75 < deg && deg <= 191.25): 'южный',
    (deg) => (191.25 < deg && deg <= 258.75): 'юго-западный',
    (deg) => (258.75 < deg && deg <= 281.25): 'западный',
    (deg) => (281.25 < deg && deg <= 348.75): 'северо-западный',
  };

  Future<Weather> from(WeatherDTO weatherDTO) async {
    final localDateTime = _getLocateDate(weatherDTO.dateTime);

    return Weather(
      date: await _getDate(localDateTime),
      time: _getTime(localDateTime),
      dayName: _getDayName(localDateTime),
      type: _getWeatherType(weatherDTO.weatherType),
      temp: weatherDTO.temp.round(),
      maxTemp: weatherDTO.maxTemp.round(),
      minTemp: weatherDTO.minTemp.round(),
      humidity: weatherDTO.humidity,
      humidityDescription: _getHumidityDescription(weatherDTO.humidity),
      windSpeed: weatherDTO.windSpeed.round(),
      windDescription: _getWindDescription(weatherDTO.windDeg),
    );
  }

  DateTime _getLocateDate(int date) {
    final sourceDate = DateTime.fromMillisecondsSinceEpoch(
      date * 1000,
      isUtc: true,
    );

    final now = DateTime.now();

    return sourceDate.add(now.timeZoneOffset);
  }

  Future<String> _getDate(DateTime dateTime) async {
    final englishDate = DateFormat("MMMM d").format(dateTime);
    return await Translator.translateText(englishDate);
  }

  String _getTime(DateTime dateTime) {
    return DateFormat.Hm().format(dateTime);
  }

  String? _getDayName(DateTime dateTime) {
    DateTime now = DateTime.now();
    final difference = DateTime(dateTime.year, dateTime.month, dateTime.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
    if (difference == 0) {
      return 'Сегодня';
    }
    if (difference == 1) {
      return 'Завтра';
    }
  }

  WeatherType _getWeatherType(String type) {
    return switch (type) {
      'Rain' => Rain(),
      'Snow' => Snow(),
      'Thunderstorm' => Thunderstorm(),
      'Drizzle' => Drizzle(),
      'Clouds' => Clouds(),
      _ => Clear(),
    };
  }

  String _getHumidityDescription(num humidity) {
    return _humidityDescriptionMap.entries
        .firstWhere((MapEntry entry) => entry.key.call(humidity))
        .value;
  }

  String _getWindDescription(num deg) {
    return _windDescriptionMap.entries
        .firstWhere((MapEntry entry) => entry.key.call(deg))
        .value;
  }
}
