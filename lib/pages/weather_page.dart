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
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}

class Rectangle9 extends StatelessWidget {
  const Rectangle9({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 390,
          height: 606,
          decoration: ShapeDecoration(
            color: const Color(0xFF67F0DF),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          ),
        ),
      ],
    );
  }
}
