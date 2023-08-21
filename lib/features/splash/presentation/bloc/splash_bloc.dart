import 'package:country_codes/country_codes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

import 'package:weather/features/home/data/DTO/location_DTO.dart';
import 'package:weather/features/home/data/DTO/weather_DTO.dart';
import 'package:weather/core/configiration/firebase_options.dart';

part 'splash_state.dart';

class SplashBloc extends Cubit<SplashState> {
  SplashBloc() : super(const SplashLoading()) {
    _load();
  }

  Future<void> _load() async {
    await CountryCodes.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await _initHive();
    emit(const SplashLoaded());
  }

  Future<void> _initHive() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(LocationDTOAdapter());
    Hive.registerAdapter(WeatherDTOAdapter());
  }
}
