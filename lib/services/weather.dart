import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  double latitude;
  double longitude;

  String weatherUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<dynamic> getCityeWeather(String cityname) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$weatherUrl?q=$cityname&appid=956167168e95545401078b2defecd238&units=metric');
    var weatherdata = await networkHelper.getdata();
    return weatherdata;
  }

  Future<dynamic> getlocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.lattitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        '$weatherUrl?lat=$latitude&lon=$longitude&appid=956167168e95545401078b2defecd238&units=metric');

    var weatherdata = await networkHelper.getdata();
    return weatherdata;
  }

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
