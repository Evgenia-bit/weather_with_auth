import 'package:hive/hive.dart';

part 'weather_DTO.g.dart';

@HiveType(typeId: 1)
class WeatherDTO {
  @HiveField(0)
  int dateTime;
  @HiveField(1)
  String weatherType;
  @HiveField(2)
  num temp;
  @HiveField(3)
  num maxTemp;
  @HiveField(4)
  num minTemp;
  @HiveField(5)
  int humidity;
  @HiveField(6)
  num windSpeed;
  @HiveField(7)
  num windDeg;

  WeatherDTO({
    required this.dateTime,
    required this.weatherType,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
  });

  WeatherDTO.fromJson(Map<String, dynamic>? json)
      : dateTime = json?["dt"],
        weatherType = json?["weather"][0]["main"],
        temp = json?["main"]["temp"],
        maxTemp = json?["main"]["temp_max"],
        minTemp = json?["main"]["temp_min"],
        humidity = json?["main"]["humidity"],
        windSpeed = json?["wind"]["speed"],
        windDeg = json?["wind"]["deg"];
}
