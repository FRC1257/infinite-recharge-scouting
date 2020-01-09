import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'home.dart';
import 'useful.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(ScoutApp());
}

class ScoutApp extends StatefulWidget {
  ScoutApp({Key key}) : super(key: key);
  @override
  ScoutAppState createState() => ScoutAppState();
}

class ScoutAppState extends State<ScoutApp> {
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team 1257 Scouting App: 2019', // year-specific
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xFF51284F),
          accentColor: Color(0xFF97D700),
          backgroundColor: Colors.transparent,
          fontFamily: 'Noto Sans'
      ),
      home: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/1257background.png'),
                    fit: BoxFit.cover
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                  backgroundColor: Colors.transparent,
                title: Text('Team 1257 Scouting App: 2019')
              ),
              body: Home()
            )
          ]
      )
    );
  }
}