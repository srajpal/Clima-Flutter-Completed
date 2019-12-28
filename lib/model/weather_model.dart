import 'package:clima/services/location.dart';
import 'package:clima/services/weather_api.dart';
import 'package:flutter/cupertino.dart';

// the WeatherModel extends ChangeNotifier which allows it to notify its
// listeners when the state has been changed
class WeatherModel extends ChangeNotifier {
  Location location = Location();
  WeatherAPI _api;

  int temperature = 0;
  int condition = 0;
  String cityName = '';
  String err = '';

  // get the location of the device and fetch the weather based on the
  // longitude and latitude returned
  Future<void> getLocationWeather() async {
    print('WeatherModel::getWeatherData()');
    err = '';
    await location.getCurrentLocation();
    print(location.longitude);
    print(location.latitude);

    // check if the device has location turned off or if we are denied access
    if (location.longitude != null) {
      _api = WeatherAPI.withLongLat(
        longitude: location.longitude,
        latitude: location.latitude,
      );
      await _api.getData();
      // check if the api called failed
      if (_api.err == '' || _api.err == null) {
        temperature = _api.temperature.toInt();
        condition = _api.condition.toInt();
        cityName = _api.cityName.toString();
      } else {
        err = _api.err;
      }
    } else {
      err = location.err;
    }

    // notify all listeners of the change to our state and tell them to
    // rebuild the UI
    notifyListeners();
  }

  // get the weather information based on a city that is passed in
  Future<void> getCityWeather(String cityToCheck) async {
    err = '';
    _api = WeatherAPI.withCity(cityName: cityToCheck);
    await _api.getData();
    if (_api.err == '' || _api.err == null) {
      temperature = _api.temperature.toInt();
      condition = _api.condition.toInt();
      cityName = _api.cityName.toString();
    } else {
      err = _api.err;
    }
    notifyListeners();
  }

  static String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  static String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
