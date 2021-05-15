import 'package:DogBreed/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatefulWidget{
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {

    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: new HomePage(),
      imageBackground: AssetImage('assets/back.png'),
      // image: Image.asset(),
      // photoSize: 249,
      // title: Text(
      //   'Dog Breed Recognaizer',
      //   style: TextStyle(
      //     fontWeight: FontWeight.bold,
      //     fontSize: 40,
      //     color: Colors.deepPurpleAccent,
      //   ),
      // ),
      // image: Image.asset('assets/logo.png'),
      // photoSize: 120,
      // backgroundColor: Colors.white,
      // loaderColor: Colors.redAccent,
      // loadingText: Text(
      //   "from Adarsh Dayanand",
      //   style: TextStyle(
      //       color: Colors.brown,
      //       fontSize: 16,
      //       fontFamily: 'sans-serif'
      //   ),
      // ),
    );

  }
}
