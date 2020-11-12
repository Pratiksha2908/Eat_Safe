import 'dart:io';
import 'dart:async';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanIngredients extends StatefulWidget {
  @override
  _ScanIngredientsState createState() => _ScanIngredientsState();
}

class _ScanIngredientsState extends State<ScanIngredients> {

  File _image;
  final picker = ImagePicker();
  var recognizedText = ' ';
  bool pressed = false;

  Future cameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future galleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getText() async {
    FirebaseVisionImage firebaseVisionImage = FirebaseVisionImage.fromFile(
        _image); //_image
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(
        firebaseVisionImage);
    setState(() {
      recognizedText = visionText.text;
      pressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Ingredients'),
        backgroundColor: Color(0xfff98b88),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      FlatButton(
                        onPressed: cameraImage,
                        child: Icon(
                          Icons.camera_alt,
                          color: Color(0xfff98b88),
                          size: 80.0,
                        ),

                      ),
                      Text('Camera',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xfff98b88),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      FlatButton(
                        onPressed: galleryImage,
                        child: Icon(
                          Icons.photo,
                          color: Color(0xfff98b88),
                          size: 80.0,
                        ),
                      ),
                      Text('Gallery',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xfff98b88)
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              elevation: 10.0,
              margin: EdgeInsets.only(right: 80.0, left: 80.0, top: 20.0),
              color: Color(0xfff98b88),
              child: FlatButton(
                onPressed: getText,
                child: Text('OK',
                  style: TextStyle(fontWeight: FontWeight.bold),),
                textColor: Colors.white,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            pressed ? Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      elevation: 10.0,
                      color: Colors.white70,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          '$recognizedText',
                          style: TextStyle(fontSize: 17.0),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    child: Card(
                      elevation: 10.0,
                      margin: EdgeInsets.only(bottom: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.check,
                            color: Color(0xfff98b88),
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                    onPressed: (){},
                  ),
                ],
              ),
            ) : SizedBox(),
          ],
        ),
      ),
    );
  }
}