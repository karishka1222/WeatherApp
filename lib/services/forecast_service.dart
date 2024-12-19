import 'package:weather_app/models/forecast_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ForecastService {
  final apiKey = '459c4f9d31a6497d63a08127ec62956e';
  
  ForecastService();

  Future<ForecastModel> getForecast(String cityName) async {
    final url = 'api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return ForecastModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}