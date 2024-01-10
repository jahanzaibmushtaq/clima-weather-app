import 'package:clima_weather_app/screens/city_screen.dart';
import 'package:clima_weather_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:clima_weather_app/services/weather.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.weatherData});
 final dynamic weatherData;
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
 int? temperature;
 String? conditionIcon;
 String? cityName;
 String? weatherMessage;
WeatherModel weatherModel = WeatherModel();
   @override
  void initState() {
  updateUi(widget.weatherData);
    super.initState();
  }

 void updateUi(dynamic weatherLocationData){
     setState(() {
       if(weatherLocationData == null){
         temperature = 0;
         conditionIcon = "Error... ";
         weatherMessage = "Unable to get the weather data!";
         cityName = " ";
         return;
       }
   double temp = weatherLocationData['main']['temp'];
   temperature = temp.toInt();
   var condition = weatherLocationData['weather'][0]['id'];
   conditionIcon = weatherModel.getWeatherIcon(condition);
   cityName = weatherLocationData['name'];
   weatherMessage = weatherModel.getMessage(temperature!);
     });

 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getWeatherLocation();
                      updateUi(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const CityScreen();
                      }));
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
                Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                     Text(
                      conditionIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
               Text(
                 "$weatherMessage $cityName!",
                 style: kMessageTextStyle,
                 textAlign: TextAlign.center,
               ),
            ],
          ),
        ),
      ),
    );
  }
}
