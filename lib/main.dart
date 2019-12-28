import 'package:clima/screens/loading_screen.dart';
import 'package:clima/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      // use ChangeNotifierProvider to expose the WeatherModel class
      // to all the dependents
      ChangeNotifierProvider<WeatherModel>(
        create: (_) => WeatherModel(),
        lazy: false,
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
