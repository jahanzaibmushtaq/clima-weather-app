import 'package:clima_weather_app/services/location.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationController newGetLocation = LocationController();

  @override
  void initState() {
    getLocation();
    super.initState();
  }

void getLocation() async {
    await newGetLocation.getLocation();
    print(newGetLocation.latitude);
    print(newGetLocation.longitude);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Expanded(
            child: Center(
              child: ElevatedButton(onPressed: (){
                getLocation();
              }, child: Text("Location"),),
            )),
      ],),
    );
  }
}
