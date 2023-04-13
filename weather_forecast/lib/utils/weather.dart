// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import 'location.dart';

const apiKey = "00893a59672eedb536717886048143c1";

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  WeatherData({required this.locationData});

  LocationHelper locationData;
  double currentTemperature = 22.0;
  int currentCondition = 25;
  String city = "Mersin";

  Future<void> getCurrentTemperature() async {
    Response response = await get(
        "http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$apiKey&units=metric"
            as Uri);

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        city = currentWeather['name'];
      } catch (e) {}
    } else {}
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 600) {
      //hava bulutlu
      return WeatherDisplayData(
          weatherIcon: const Icon(FontAwesomeIcons.cloud,
              size: 75.0, color: Colors.white),
          weatherImage: const AssetImage('assets/bulutlu.png'));
    } else {
      //hava iyi
      //gece gündüz kontrolü
      var now = DateTime.now();
      if (now.hour >= 19) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.moon,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('assets/gece.png'));
      } else {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.sun,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('assets/gunesli.png'));
      }
    }
  }
}
