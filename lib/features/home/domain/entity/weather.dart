class Weather {
  String date;
  String time;
  String? dayName;
  WeatherType type;
  num temp;
  num maxTemp;
  num minTemp;
  int humidity;
  String humidityDescription;
  num windSpeed;
  String windDescription;

  Weather({
    required this.date,
    required this.time,
    required this.dayName,
    required this.type,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.humidity,
    required this.humidityDescription,
    required this.windSpeed,
    required this.windDescription,
  });
}

sealed class WeatherType {
  abstract String label;
  abstract String imageFileName;
}

class Rain extends WeatherType {
  @override
  String imageFileName = 'rain.png';

  @override
  String label = 'Дождь';
}

class Snow extends WeatherType {
  @override
  String imageFileName = 'snow.png';

  @override
  String label = 'Снег';
}

class Clear extends WeatherType {
  @override
  String imageFileName = 'sun.png';

  @override
  String label = 'Ясно';
}

class Drizzle extends WeatherType {
  @override
  String imageFileName = 'rain.png';

  @override
  String label = 'Мелкий дождь';
}

class Thunderstorm extends WeatherType {
  @override
  String imageFileName = 'thunderstorm.png';

  @override
  String label = 'Гроза';
}

class Clouds extends WeatherType {
  @override
  String imageFileName = 'clouds.png';

  @override
  String label = 'Облачно';
}
