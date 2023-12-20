import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('cbe98178fd589e99f2e0f03fa5dfc2b4');
  Weather? _weather;

  _fetchWeather() async {
    try {
      final weather = await _weatherService.getWeatherByLatLong();
      setState(() {
        _weather = weather;
      });
    } catch (e) {}
  }

//Weather Animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunny.json'; //default otomatis ke sunny
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'clear':
        return 'assets/sunny.json';
      case 'night':
        return 'assets/night.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading City.."),

            //Animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            //Temperatur
            Text('${_weather?.temperature.round()}°C'),

            //Weather Condition
            Text(_weather?.mainCondition ?? ""),
            const SizedBox(height: 32),

            Container(
              width: 300,
              height: 60,
              decoration: ShapeDecoration(
                color: const Color.fromARGB(255, 80, 185, 173),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _weather?.cityName ?? "Loading City..",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Lottie.asset(
                    getWeatherAnimation(_weather?.mainCondition),
                    height: 30, // You can customize the height
                    width: 30, // You can customize the width
                  ),
                  Text(
                    '${_weather?.temperature.round()}°C',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    _weather?.mainCondition ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
