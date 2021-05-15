import 'dart:developer';
import 'dart:math';

import 'package:DogBreed/MySplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();

  } on CameraException catch (e) {
    print("Errorrr: " + e.description);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Breed Classifier',
      debugShowCheckedModeBanner: false,
      home: MySplashScreen(),
    );
  }
}
