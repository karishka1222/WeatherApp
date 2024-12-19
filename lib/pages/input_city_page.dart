import 'package:flutter/material.dart';
import 'package:weather_app/components/my_textfiled.dart';
import 'package:weather_app/pages/weather_page.dart';

class InputCityPage extends StatefulWidget {


  InputCityPage({super.key});

  @override
  State<InputCityPage> createState() => _InputCityPageState();
}

class _InputCityPageState extends State<InputCityPage> {
  final TextEditingController _controller = TextEditingController();

  void navigateToWeatherScreen() {
    final String cityName = _controller.text;
    if (cityName.isEmpty) {
      AlertDialog();
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherPage(cityName: cityName,)));
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please enter city name for which you want to find out the weather", 
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,

              ),
            ),
            SizedBox(height: 50,),
            MyTextField(hintText: "Enter city name", obscureText: false, controller: _controller),
            SizedBox(height: 50,),
            ElevatedButton(
              onPressed: navigateToWeatherScreen, 
              child: Text("Get weather"),
            ),
          ],
        ),
      ),
    );
  }
}
