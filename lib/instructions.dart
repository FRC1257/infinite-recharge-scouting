import 'package:flutter/material.dart';

class Instructions extends StatefulWidget {
  Instructions({Key key}) : super(key: key);
  @override
  InstructionsState createState() => InstructionsState();
}

class InstructionsState extends State<Instructions> {
  static List<String> instructions = ['Setup',
    'If Team 1257 has given you this app to use for scouting, we\'ve also given you objective and pit form IDs. Copy and paste them into the appropriate fields on the Settings page.',
    'Change the robot field on the Settings page to each robot that is to be scouted by each device (make sure they\'re all different else you\'ll get duplicate data!)',
    'For any Android device that will not have an intenet connection (e.g. tablets without cellular data), Bluetooth pair it with a device that does and is running this app.',
    'Objective and Pit',
    'It\'s pretty self-explanatory. Fill in the fields and hit submit when done.',
    'Sending',
    'If your device has an internet connection while scouting, data should be sent to the spreadsheet as soon as it is submitted.',
    'Anything that hasn\'t been sent will be saved on the error logs, and can be loaded and uploaded on the Send screen whenever your device has an internet connection.',
    'Alternatively, if you need to send without an internet connection (this requires Android), make sure the paired device is running the app, and accept connections on that device before sending data.',
    'Have fun scouting!']; // year-specific
  String text = instructions[0];
  int a = 0;
  void nextPage() {
    setState(() {
      text = instructions[(a + 1) % instructions.length];
      a++;
    });
  }
  void prevPage() {
    setState(() {
      text = instructions[(a - 1) % instructions.length];
      a = (a - 1) % instructions.length;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0.0, top: 12.0), child: Center(child: Text('Instructions', style: TextStyle(fontSize: 22)))),
          Expanded(child: Padding(padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 48.0), child: Center(child: Text(text, textAlign: TextAlign.center)))),
          Row(
            children: <Widget>[
              Expanded(
                  child: Row(
                    children: <Widget>[
                      FloatingActionButton(
                          onPressed: prevPage,
                          tooltip: 'Previous Page',
                          child: IconTheme(data: IconThemeData(color: Color(0xFF51284F)), child: Icon(Icons.arrow_back_ios))
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
              ),
              Expanded(
                  child: Row(
                    children: <Widget>[
                      FloatingActionButton(
                          onPressed: nextPage,
                          tooltip: 'Next Page',
                          child: IconTheme(data: IconThemeData(color: Color(0xFF51284F)), child: Icon(Icons.arrow_forward_ios))
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}