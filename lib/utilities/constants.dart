import 'package:flutter/material.dart';

const TextStyle kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const TextStyle kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const TextStyle kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const TextStyle kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

// please register for your own API KEY
const String OPEN_WEATHER_API_KEY = 'e805b082e7123d78e6c5365f2287d02e';
const String OPEN_WEATHER_API_URL_LAT_LONG =
    'https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&units={units}&appid=$OPEN_WEATHER_API_KEY';
const String OPEN_WEATHER_API_URL_CITY =
    'https://api.openweathermap.org/data/2.5/weather?q={city}&units={units}&appid=$OPEN_WEATHER_API_KEY';

const InputDecoration kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
