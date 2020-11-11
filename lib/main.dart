import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Eat Safe')),
        backgroundColor: Color(0xfff98b88),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.all(40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  onPressed: (){},
                  child: Image.asset('images/disease.png'),
                ),
              ),
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.all(40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  onPressed: (){},
                  child: Image.asset('images/pregnant.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

