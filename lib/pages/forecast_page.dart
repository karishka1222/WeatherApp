import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/input_city_page.dart';
import 'package:weather_app/services/forecast_service.dart';
import 'package:weather_app/services/weather_service.dart';

class ForecastPage extends StatefulWidget {
  final String cityName;

  ForecastPage({super.key, required this.cityName});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  final _forecastService = ForecastService();
  ForecastModel? _forecastModel;

  fetchForecast() async {
    try {
      final forecast = await _forecastService.getForecast(widget.cityName);
      setState(() {
        _forecastModel = forecast;
      });
    } catch (e) {
      print(e);
    }
  }

  void navigateToWeatherScreen() {
    Navigator.pop(context);
  }

  void navigateToInputScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => InputCityPage()));
  }

  @override
  void initState() {
    super.initState();
    fetchForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Forecast for 4 days",
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
              SizedBox(height: 25,),
              Text(
                '${widget.cityName}',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text('${_forecastModel?.day1.date}'),
              Text('${_forecastModel?.day1.temperature}'),
              Text('${_forecastModel?.day1.condition}'),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: navigateToWeatherScreen, 
                    child: Text("Return to current weather"),
                  ),
                  ElevatedButton(
                    onPressed: navigateToInputScreen, 
                    child: Text("Choose another city"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}