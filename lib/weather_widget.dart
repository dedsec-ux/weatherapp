import 'package:flutter/material.dart';
import 'weather_service.dart';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Map<String, dynamic>? weatherData;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      final data = await WeatherService().fetchWeather('London');
      setState(() {
        weatherData = data;
        errorMessage = ''; // Clear error message
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load weather data: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (weatherData == null && errorMessage.isEmpty) {
      return CircularProgressIndicator();
    }
    if (errorMessage.isNotEmpty) {
      return Text(errorMessage, style: TextStyle(color: Colors.red));
    }
    return Text('Temperature: ${weatherData!['main']['temp']}°K');
  }
}
