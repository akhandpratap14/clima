import 'package:flutter/material.dart';
import 'package:flutterclima/utilities/constants.dart';
import 'package:flutterclima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.LocationWeather});

  final LocationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int tempreature;
  late String WeatherIcon;
  late String weatherMessage;
  late String cityName;
  @override
  void initState() {
    super.initState();
    updateUI(widget.LocationWeather);
  }

  void updateUI(weatherData) {
    setState(() {
      if (weatherData == null) {
        tempreature = 0;
        WeatherIcon = 'Error';
        weatherMessage = 'Unable to get Data from Server !';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      tempreature = temp.toInt();
      weatherMessage = weather.getMessage(tempreature);
      var condition = weatherData['weather'][0]['id'];
      WeatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$tempreature',
                      style: kTempTextStyle,
                    ),
                    Text(
                      WeatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

    // var temp = decodeData['main']['temp'];
    // var condition = decodeData['weather'][2]['description'];
    // var cityName = decodeData['name'];
