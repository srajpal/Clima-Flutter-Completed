import 'package:clima/utilities/constants.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/foundation.dart';

// fetch weather data from HTTP REST API
class WeatherAPI {
  WeatherAPI.withLongLat({@required longitude, @required latitude}) {
    _url = OPEN_WEATHER_API_URL_LAT_LONG;
    _url = _url.replaceAll('{lon}', longitude.toString());
    _url = _url.replaceAll('{lat}', latitude.toString());
    _url = _url.replaceAll('{units}', 'Imperial');
    print(_url);
  }

  WeatherAPI.withCity({@required String cityName}) {
    _url = OPEN_WEATHER_API_URL_CITY;
    _url = _url.replaceAll('{city}', cityName);
    _url = _url.replaceAll('{units}', 'Imperial');
    print(_url);
  }

  dynamic _json;
  String _url;
  dynamic _cod;
  dynamic temperature;
  dynamic condition;
  dynamic cityName;
  String err;

  Future<void> getData() async {
    print('WeatherAPI::getData()');
    _json = await NetworkHelper(url: _url).fetchData();
    _cod = _json['cod'] ?? 0;
    // if the HTTP code is "ok" get the info from the JSON returned
    if (_cod == 200 || _cod == "200") {
      temperature = _json['main']['temp'] ?? 0;
      condition = _json['weather'][0]['id'] ?? 0;
      cityName = _json['name'] ?? '';
      print('temp: ' + temperature.toString());
      print('cond: ' + condition.toString());
      print('city: ' + cityName.toString());
    } else {
      // an error specific to our API
      err = _json['message'] ?? 'API ERROR';
    }
  }
}
