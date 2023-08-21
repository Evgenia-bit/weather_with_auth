part of 'weather_bloc.dart';

class WeatherState {
  final List<Weather> forecast;
  final Location? location;
  final int activeWeatherIndex;
  final bool isLoading;
  final String errorMessage;

  Weather get activeWeather => forecast[activeWeatherIndex];

  WeatherState({
    this.forecast = const [],
    this.location,
    this.activeWeatherIndex = 0,
    this.isLoading = true,
    this.errorMessage = '',
  });

  WeatherState copyWith({
    List<Weather>? forecast,
    Location? location,
    int? activeWeatherIndex,
    bool isLoading = false,
    String errorMessage = '',
  }) {
    return WeatherState(
      forecast: forecast ?? this.forecast,
      location: location ?? this.location,
      activeWeatherIndex: activeWeatherIndex ?? this.activeWeatherIndex,
      isLoading: isLoading,
      errorMessage: errorMessage,
    );
  }
}
