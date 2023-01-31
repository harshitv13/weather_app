import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/model/weather_model.dart';

class LocationScreen extends StatelessWidget {
  final controller = Get.put(WeatherController());
  final weatherStatus = Get.put(WeatherStatus());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: FutureBuilder<Weather>(
          future: controller.getWeatherData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error.toString()}"),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              var weatherIcon = weatherStatus.getWeatherIcon(data?.cod ?? 0);

              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('images/location_background.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.8), BlendMode.dstATop),
                  ),
                ),
                constraints: BoxConstraints.expand(),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${data?.main.temp.toInt().toString()}°",
                              style: TextStyle(fontSize: 100.0, color: Colors.white),
                            ),
                            Text(
                              weatherStatus.getWeatherIcon(data?.cod ?? 0),
                              style: TextStyle(fontSize: 76),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: TextButton(
                          onPressed: () {
                            controller.getWeatherData();
                          },
                          child: const Icon(
                            Icons.near_me,
                            size: 50.0,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: SpinKitDoubleBounce(
                color: Colors.blue,
                size: 50.0,
              ),
            );
          }),
    );
  }
}

class WeatherStatus {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}