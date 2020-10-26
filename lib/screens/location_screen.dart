import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final locationweather;
  LocationScreen({this.locationweather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String city;
  String weatherIcon;
  int temp;
  String message;
  WeatherModel weathermodel = WeatherModel();

  @override
  void initState() {
    super.initState();
    changeUI(widget.locationweather);
  }

  void changeUI(weatherInfo) async {
    //final weatherdata = await weatherInfo;
    setState(() {
      if (weatherInfo == null) {
        temp = 0;
        city = '';
        weatherIcon = "error";
        message = 'unable to get weather data ';
        return;
      }

      // String description = weatherdata['weather'][0]['description'];
      int condition = weatherInfo['weather'][0]['id'];
      double temperature = weatherInfo['main']['temp'].toDouble();
      temp = temperature.toInt();
      weatherIcon = weathermodel.getWeatherIcon(condition);
      message = weathermodel.getMessage(temp);
      city = weatherInfo['name'].toString();
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
                    onPressed: () async {
                      var weatherdata = await weathermodel.getlocationWeather();
                      changeUI(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var returnedCity = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (returnedCity != null) {
                        var weatherdata =
                            await weathermodel.getCityeWeather(returnedCity);
                        changeUI(weatherdata);
                      }
                    },
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
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $city!',
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

// var weatherdata = await networkHelper.getdata();
