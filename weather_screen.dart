import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic>? weatherData;

  Future<void> fetchWeatherData() async {
    final apiKey = '1829a2600d014c0f8a1144001232906';
    final city = 'Medan';

    final response = await http.get(Uri.parse(
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city'));
    final data = json.decode(response.body);

    setState(() {
      weatherData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Cuaca Hari Ini'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      final location = weatherData!['location']['name'];
      final temperature = weatherData!['current']['temp_c'];
      final condition = weatherData!['current']['condition']['text'];

      return Scaffold(
        appBar: AppBar(
          title: const Text('Cuaca Hari Ini'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
    
          ],
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Location: $location',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Temperature: $temperature°C',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Condition: $condition',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 105, 109),
      );
    }
  }
}