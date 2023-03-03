import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/domain/model/weather_model/weather_model.dart';
import 'package:weather/infrastracture/home_screen_repo.dart';

// class helps to store api result to hive database
class DataBaseHelper {
  Future<WeatherModel?> weatherDataHelper() async {
    var box = await Hive.openBox<WeatherModel>('WeatherDataDb');
    var data = await WeatherRepository().fetchWeather();
    Current? currentData = data.current;
    Location? locationData = data.location;

    await box.put(
        'WeatherData',
        WeatherModel()
          ..current = currentData
          ..location = locationData);
    final weatherReport = box.get('WeatherData');
    return weatherReport;
  }
}
