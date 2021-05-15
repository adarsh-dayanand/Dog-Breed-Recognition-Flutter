import 'package:DogBreed/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage>{

  bool isWorking = false;
  String result = "";
  CameraController cameraController;
  CameraImage cameraImage;

  initCamera(){

    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraController.initialize().then((value){
      if(!mounted){
        return;
      }
      setState((){
        cameraController.startImageStream((image) => {
          if(!isWorking){
            isWorking = true,
            cameraImage = image,
            runModelOnStreamFrames(),
          }
        });
      });
    });

  }

  runModelOnStreamFrames() async {
    if(cameraImage != null){
      var recognitions = await Tflite.runModelOnFrame(
          bytesList: cameraImage.planes.map((plane){
            return plane.bytes;
          }).toList(),

          imageHeight: cameraImage.height,
          imageWidth: cameraImage.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true,
      );

      result = "";
      recognitions.forEach((res) {
        result += res["label"] + "  " + (res["confidence"] as double).toStringAsFixed(2) + "\n \n";
      });

      setState(() {
        result;
      });

      isWorking = false;

    }
  }

  loadModel () async {
    await Tflite.loadModel(model: "assets/model.tflite", labels: "assets/labels.txt");
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  void dispose() async {
    super.dispose();

    await Tflite.close();
    cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/search.png"),
                fit: BoxFit.fill,
              )
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 320,
                        width: 360,
                        // child: Image.asset("assets/frame.jpg"),
                      ),
                    ),

                    Center(
                      child: FlatButton(
                        onPressed: (){
                          initCamera();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 35),
                          height: 300,
                          width: 360,
                          child: cameraImage == null ? Container(
                            height: 270,
                            width: 360,
                            child: Icon(Icons.photo_camera_front, color: Colors.blueAccent, size: 40,),
                          ) :
                          AspectRatio(
                            aspectRatio: cameraController.value.aspectRatio,
                            child: CameraPreview(cameraController),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 55.0),
                    child: SingleChildScrollView(
                      child: Text(
                        result,
                        style: TextStyle(
                          backgroundColor: Colors.white30,
                          fontSize: 30.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

}