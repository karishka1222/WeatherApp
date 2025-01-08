import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherBloc {
  final _currentStreamController =
      StreamController<Map<String, dynamic>>.broadcast();
  final _forecastStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get currentStream =>
      _currentStreamController.stream;
  Stream<Map<String, dynamic>> get forecastStream =>
      _forecastStreamController.stream;

  final apiKey = '459c4f9d31a6497d63a08127ec62956e';

  void fetchCurrentWeather(String cityName) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        _currentStreamController.add(json.decode(response.body));
      } else {
        _currentStreamController.addError('Failed to fetch weather');
      }
    } catch (e) {
      _currentStreamController.addError('Error: $e');
    }
  }

  void fetchForecast(String cityName) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        _forecastStreamController.add(json.decode(response.body));
      } else {
        _forecastStreamController.addError('Failed to fetch weather');
      }
    } catch (e) {
      _forecastStreamController.addError('Error: $e');
    }
  }
}
