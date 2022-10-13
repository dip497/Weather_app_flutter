import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:lab_assignment/model/weather_model.dart';
import 'package:lab_assignment/serivce/weather_api_client.dart';
import 'package:lab_assignment/views/current_weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: home(),
    );
  }
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  WeatherApiClient client = WeatherApiClient();
  TextEditingController name = new TextEditingController();
  String cityname = "";

  Weather data = Weather();
  Future<void> getData() async {
    data = (await client.getCurrentWeather(cityname))!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf9f9f9),
        appBar: AppBar(
          backgroundColor: Color(0xFFf9f9f9),
          elevation: 0.0,
          title:
              const Text("Weather App", style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 18),
                    child: TextField(
                      controller: name,
                      autocorrect: true,
                      decoration: const InputDecoration(
                        hintText: 'City Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.black26, width: 2),
                        ),
                        labelText: 'City',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        String city = name.text.toString();
                        setState(() {
                          cityname = city;
                        });
                      },
                      child: const Text(
                        'Get',
                        style: TextStyle(color: Colors.black),
                      )),
                  currentWeather(Icons.wb_sunny_rounded, "${data.temp}",
                      "${data.cityName}"),
                  SizedBox(
                    height: 60,
                  ),
                  Text("Additional Information",
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Color(0xdd212121),
                          fontWeight: FontWeight.bold)),
                  Divider(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                            leading: FaIcon(FontAwesomeIcons.wind),
                            title: Text("wind"),
                            trailing: Text("${data.wind}")),
                        ListTile(
                            leading: FaIcon(FontAwesomeIcons.sun),
                            title: Text("Humidity"),
                            trailing: Text("${data.humidity}")),
                        ListTile(
                            leading: FaIcon(FontAwesomeIcons.tachographDigital),
                            title: Text("Pressure"),
                            trailing: Text("${data.pressure}")),
                      ],
                    ),
                  )),
                  // Column(
                  //   children: [
                  //     Row(
                  //       children: [Text("Wind"), Text("${data.wind}")],
                  //     ),
                  //     Text("wind : ${data.wind}"),
                  //     Text("humidity : ${data.humidity}"),
                  //     Text("pressure : ${data.pressure}"),
                  //   ],
                  // )
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return Container();
          },
        ));
  }
}
