import 'package:hive/hive.dart';

part 'location_DTO.g.dart';

@HiveType(typeId: 0)
class LocationDTO {
  @HiveField(0)
  String city;
  @HiveField(1)
  String countryCode;

  LocationDTO({
    required this.city,
    required this.countryCode,
  });

  LocationDTO.fromJson(Map<String, dynamic>? json)
      : city = json?['name'],
        countryCode = json?['sys']['country'];
}
