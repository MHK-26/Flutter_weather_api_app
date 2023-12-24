import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/weather.dart';

class HomeScreen extends StatefulWidget {
  final WeatherData weatherData;

  const HomeScreen({super.key, required this.weatherData});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? temp;
  AssetImage? backgroundImg;
  Icon? weatherDisplayIcon;
  String? mainWeather;
  String? descWeather;
  String? timeZone;
  updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temp = weatherData.currentTemp!.round();
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();

      backgroundImg = weatherDisplayData.weatherImg;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
      mainWeather = weatherDisplayData.mainWeather;
      descWeather = weatherDisplayData.descWeather;
      timeZone = weatherDisplayData.timeZone;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    final f = new DateFormat('dd MMM, yyy HH:mm');
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(image: backgroundImg!, fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: weatherDisplayIcon,
                      ),
                      Container(
                        child: Text(
                          f.format(DateTime.now().toLocal()).toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '$temp°',
                        style: TextStyle(color: Colors.white, fontSize: 100),
                      ),
                      Column(
                        children: [
                          Text(
                            '$mainWeather',
                            style: TextStyle(color: Colors.white, fontSize: 50),
                          ),
                          Text(
                            '$descWeather',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    '$timeZone',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
