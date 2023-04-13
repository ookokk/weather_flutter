import 'package:flutter/material.dart';

import '../utils/weather.dart';

class MainScreen extends StatefulWidget {
  final WeatherData weatherData;

  const MainScreen({super.key, required this.weatherData});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  late String city;
  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature.round();
      city = weatherData.city;
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              child: weatherDisplayIcon,
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                '$temperature°',
                style: const TextStyle(
                    color: Colors.white, fontSize: 80.0, letterSpacing: -5),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                city,
                style: const TextStyle(
                    color: Colors.white, fontSize: 50.0, letterSpacing: -5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
