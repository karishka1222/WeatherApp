import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/forecast_page.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  final String cityName;

  WeatherPage({super.key, required this.cityName});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
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

  void navigateToInputScreen() {
    Navigator.pop(context);
  }

  void navigateToForecastScreen() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => ForecastPage(cityName: widget.cityName,)));
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
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
                ],
              ),
              Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: navigateToInputScreen, 
                        child: Text("Choose another city"),
                      ),
                      SizedBox(width: 10,),
                      ElevatedButton(
                        onPressed: navigateToForecastScreen, 
                        child: Text("Check forecast"),
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