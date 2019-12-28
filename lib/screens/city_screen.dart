import 'package:clima/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:provider/provider.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  decoration: kTextFieldInputDecoration,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    setState(() {
                      cityName = value;
                    });
                  },
                ),
              ),
              Builder(
                // use a builder to pass the Scaffold context through Flatbutton
                // to the SnackBar Widget
                builder: (context) => FlatButton(
                  onPressed: () async {
                    if (cityName != null && cityName != '') {
                      await Provider.of<WeatherModel>(context)
                          .getCityWeather(cityName);
                      // if we have an error from the API use SnackBar to show it
                      if (Provider.of<WeatherModel>(context).err != null &&
                          Provider.of<WeatherModel>(context).err != '') {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              Provider.of<WeatherModel>(context).err,
                            ),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    } else {
                      // No city name but button pressed
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please enter a city name to check for.',
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Get Weather',
                    style: kButtonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
