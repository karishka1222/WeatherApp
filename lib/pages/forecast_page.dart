import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/input_city_page.dart';
import 'package:weather_app/services/weather_service.dart';

class ForecastPage extends StatefulWidget {
  final String cityName;

  ForecastPage({super.key, required this.cityName});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  final _weatherService = WeatherService();
  WeatherModel? _weather;

  fetchWeather() async {
    try {
      final weather = await _weatherService.getWeather(widget.cityName);
      setState(() {
        _weather = weather;
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
    fetchWeather();
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
                "Today's weather",
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
              SizedBox(height: 25,),
              Text(
                '${_weather?.cityName}',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '${_weather?.temperature} °C',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w300,
                  ),
              ),
              SizedBox(height: 10),
              Text(
                '${_weather?.condition}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
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