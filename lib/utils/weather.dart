import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:weather_app/utils/location.dart';

const weatherApiKey = 'fc97c15c075d0b7cf0e657249c118cf6';

class WeatherDisplayData {
  Icon? weatherIcon;
  AssetImage? weatherImg;
  String? mainWeather;
  String? descWeather;
  String? timeZone;
  WeatherDisplayData(
      {required this.weatherIcon,
      required this.weatherImg,
      required this.mainWeather,
      required this.descWeather,
      required this.timeZone});
}

class WeatherData {
  WeatherData({required this.locationHelper});
  late LocationHelper locationHelper;

  double? currentTemp;
  int? currentCondition;
  String? mainWeather;
  String? descWeather;
  String? timeZone;
  Future<void> getCurrentTemp() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${locationHelper.latitude}&lon=${locationHelper.longitude}&appid=${weatherApiKey}&units=metric');
    Response response = await get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);
      try {
        currentTemp = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        mainWeather = currentWeather['weather'][0]['main'];
        descWeather = currentWeather['weather'][0]['description'];
        timeZone = currentWeather['sys']['country'];
      } catch (e) {
        print(e.toString());
      }
    } else {
      print('No Data from Api');
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition! < 600) {
      return WeatherDisplayData(
          weatherIcon: const Icon(
            FontAwesomeIcons.cloudRain,
            size: 50,
            color: Colors.white,
          ),
          weatherImg: const AssetImage('assets/imgs/rainy.jpg'),
          mainWeather: mainWeather,
          descWeather: descWeather,
          timeZone: timeZone);
    } else {
      var now = new DateTime.now();
      if (now.hour >= 18 || now.hour <= 5) {
        return WeatherDisplayData(
            weatherIcon: const Icon(
              FontAwesomeIcons.moon,
              size: 50,
              color: Colors.white,
            ),
            weatherImg: const AssetImage('assets/imgs/night.jpg'),
            mainWeather: mainWeather,
            descWeather: descWeather,
            timeZone: timeZone);
      } else {
        return WeatherDisplayData(
            weatherIcon: const Icon(
              FontAwesomeIcons.sun,
              size: 50,
              color: Colors.white,
            ),
            weatherImg: const AssetImage('assets/imgs/cloudy.jpg'),
            mainWeather: mainWeather,
            descWeather: descWeather,
            timeZone: timeZone);
      }
    }
  }
}
