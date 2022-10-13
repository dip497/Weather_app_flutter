import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;

import '../model/weather_model.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    print(location);
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=${location}&appid=89c391678f289337ace893bdf39b1a98");

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    print(endpoint);
    return Weather.fromJson(body);
  }
}
