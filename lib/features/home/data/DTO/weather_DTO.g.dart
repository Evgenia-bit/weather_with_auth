// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_DTO.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherDTOAdapter extends TypeAdapter<WeatherDTO> {
  @override
  final int typeId = 1;

  @override
  WeatherDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherDTO(
      dateTime: fields[0] as int,
      weatherType: fields[1] as String,
      temp: fields[2] as num,
      maxTemp: fields[3] as num,
      minTemp: fields[4] as num,
      humidity: fields[5] as int,
      windSpeed: fields[6] as num,
      windDeg: fields[7] as num,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherDTO obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.weatherType)
      ..writeByte(2)
      ..write(obj.temp)
      ..writeByte(3)
      ..write(obj.maxTemp)
      ..writeByte(4)
      ..write(obj.minTemp)
      ..writeByte(5)
      ..write(obj.humidity)
      ..writeByte(6)
      ..write(obj.windSpeed)
      ..writeByte(7)
      ..write(obj.windDeg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
