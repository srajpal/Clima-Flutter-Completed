import 'package:clima/screens/location_screen.dart';
import 'package:clima/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // if an error occurred while getting the device location or when fetching
  // the weather information using the api capture the info and show it to
  // the user
  String err = '';

  // check the location and api on first launch.
  // if an error occurs we will not continue to the next screen
  void getDataAndGo() async {
    // use Provider to call a method on the WeatherModel class
    await Provider.of<WeatherModel>(context).getLocationWeather();
    // check the error property of the WeatherModel class to see if an error
    // occurred and we will use that error to inform the user
    if (Provider.of<WeatherModel>(context).err == '' ||
        Provider.of<WeatherModel>(context).err == null) {
      // no error continue to LocationScreen
      // use pushReplacement so we cannot go back to the screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LocationScreen();
          },
        ),
      );
    } else {
      // set the local error state to inform user
      setState(() {
        err = Provider.of<WeatherModel>(context).err;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // use Future.mocrotask in order to wait for the initState to complete
    // this is stated under the FAQ for Provider,
    // https://pub.dev/documentation/provider/latest/
    Future.microtask(() => getDataAndGo());
  }

  @override
  Widget build(BuildContext context) {
    print('LoadingScreen::build()');
    if (err == '' || err == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(err),
          ),
        ),
      );
    }
  }
}
