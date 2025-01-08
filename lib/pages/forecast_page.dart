import 'package:flutter/material.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

class ForecastPage extends StatelessWidget {
  final String cityName;
  final WeatherBloc weatherBloc = WeatherBloc();

  ForecastPage({super.key, required this.cityName}) {
    weatherBloc.fetchForecast(cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$cityName's forecast"),
      ),
      body: Center(
        child: StreamBuilder<Map<String, dynamic>>(
          stream: weatherBloc.forecastStream,
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
              final forecast = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: forecast['list'].length,
                itemBuilder: (context, index) {
                  final item = forecast['list'][index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        'Date: ${item['dt_txt']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Temp: ${item['main']['temp']} °C\nCondition: ${item['weather'][0]['description']}',
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
