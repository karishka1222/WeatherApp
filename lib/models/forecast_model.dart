import 'package:weather_app/models/weather_model.dart';

class ForecastModel {
  final WeatherModel day1;
  final WeatherModel day2;
  final WeatherModel day3;
  final WeatherModel day4;
  final String cityName;

  ForecastModel({
    required this.day1,
    required this.day2,
    required this.day3,
    required this.day4,
    required this.cityName,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final String name = json['city']['name'];
    final day11 = WeatherModel(cityName: name, temperature: json['list'][0]['main']['temp'].toDouble(), condition: json['list'][0]['weather']['description'], date: json['list'][0]['dt_txt']);
    final day21 = WeatherModel(cityName: name, temperature: json['list'][1]['main']['temp'].toDouble(), condition: json['list'][1]['weather']['description'], date: json['list'][1]['dt_txt']);
    final day31 = WeatherModel(cityName: name, temperature: json['list'][2]['main']['temp'].toDouble(), condition: json['list'][2]['weather']['description'], date: json['list'][2]['dt_txt']);
    final day41 = WeatherModel(cityName: name, temperature: json['list'][3]['main']['temp'].toDouble(), condition: json['list'][3]['weather']['description'], date: json['list'][3]['dt_txt']);
    return ForecastModel(
      cityName: json['city']['name'], 
      day1: day11,
      day2: day21,
      day3: day31,
      day4: day41,
    );
  }
}