import 'package:clima_weather_app/services/location.dart';
import 'package:clima_weather_app/services/networking.dart';

const String apiKey = "87cc576e55ead33ed0bf394836847227";
const String apiUrl = "https://api.openweathermap.org/data/2.5/weather";
class WeatherModel {

  Future<dynamic> getWeatherLocation() async{
    LocationController newGetLocation = LocationController();
    await newGetLocation.getLocation();

    NetworkHelper networkHelper = NetworkHelper(
        url:
        "$apiUrl?lat=${newGetLocation.latitude}&lon=${newGetLocation.longitude}&appid=$apiKey&units=metric");
    var weatherData = await networkHelper.getData();
    return weatherData;
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
