import 'package:flutter/cupertino.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherProvider extends ChangeNotifier{
  WeatherModel? _weatherData;
  String? nameCity;

  set weatherData(WeatherModel? weather){
    _weatherData = weather;
    notifyListeners();
  }
  WeatherModel? get weatherData => _weatherData;
}

