import 'package:flutter/material.dart';

import 'package:weather/core/utils/translator.dart';
import 'package:weather/features/home/data/DTO/location_DTO.dart';
import 'package:weather/features/home/domain/entity/location.dart';
import 'package:country_codes/country_codes.dart';

class LocationMapper {
  Future<Location> from(LocationDTO locationDTO) async {
    return Location(
      city: await _getCity(locationDTO.city),
      country: _getCountry(locationDTO.countryCode),
    );
  }

  Future<String> _getCity(String city) async {
    return await Translator.translateText(city);
  }

  String _getCountry(String code) {
    Locale loc = Locale("en", code);
    final CountryDetails details = CountryCodes.detailsForLocale(loc);
    return details.name ?? '';
  }
}
