import 'package:flutter/material.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/forecast_page.dart';

class WeatherPage extends StatelessWidget {
  final String cityName;
  final WeatherBloc weatherBloc = WeatherBloc();

  WeatherPage({super.key, required this.cityName}) {
    weatherBloc.fetchCurrentWeather(cityName);
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
              StreamBuilder<Map<String, dynamic>>(
                stream: weatherBloc.currentStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: Text('No data available'),
                    );
                  } else {
                    final weather = snapshot.data as Map<String, dynamic>;
                    final _weather = WeatherModel.fromJson(weather);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Today's weather",
                          style: TextStyle(
                            fontSize: 35,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          '${_weather.cityName}',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${_weather.temperature} °C',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${_weather.condition}',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Choose another city"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForecastPage(
                                  cityName: cityName,
                                ))),
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
