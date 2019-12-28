import 'package:clima/model/weather_model.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('LocationScreen::build()');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      // call a method on our WeatherModel using Provider,
                      // we do not need anything to force our UI to update.
                      // The UI will update when the notifyListeners() is called
                      // inside .getLocationWeather()
                      Provider.of<WeatherModel>(context).getLocationWeather();
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return CityScreen();
                          },
                        ),
                      );
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      Provider.of<WeatherModel>(context)
                              .temperature
                              .toString() +
                          '°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      WeatherModel.getWeatherIcon(
                        // use the value from the WeatherModel through Provider
                        Provider.of<WeatherModel>(context).condition,
                      ),
                      style: kTempTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  WeatherModel.getMessage(
                        Provider.of<WeatherModel>(context).temperature,
                      ) +
                      ' in ' +
                      Provider.of<WeatherModel>(context).cityName +
                      '!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
