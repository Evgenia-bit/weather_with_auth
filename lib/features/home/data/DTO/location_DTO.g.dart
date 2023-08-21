// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_DTO.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationDTOAdapter extends TypeAdapter<LocationDTO> {
  @override
  final int typeId = 0;

  @override
  LocationDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationDTO(
      city: fields[0] as String,
      countryCode: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocationDTO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.city)
      ..writeByte(1)
      ..write(obj.countryCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
