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
    'Objective', 'Each field is pretty self-explanatory. You\'ll just have to remember a few things (hit me up if something else seems unclear): ', 'Auto power cells are different from teleop power cells (the latter group is marked by the arrows).',
    'If a power cell lands in the high goal, but you are not sure whether it is in the inner goal or not, mark it as outer.',
    'Whenever there is a tried option, that means tried AND failed.',
    'Pit',
    'At competition, you should be using the tablets, so I don\'t even know why you\'re using this web app unless something has gone horribly wrong. I\'m still leaving it here because better safe than sorry.',
    'Pretty much everything in pit scouting is pretty self-explanatory. Don\'t interrupt teams, be as GP as possible, and ask teams about all the categories. Some clarifications (again, hit me up if something else is unclear):',
    'Role means their role, not yours.', 'Vision means vision targeting.', 'It\'s more helpful if for speed, and especially weight and height, you get an exact number, but if you don\'t, don\'t sweat it.', 'Make sure you DO get any drivetrain information (there will generally be a build member in the pit who has that information on hand.',
    'When recording drive team experience, be sure to distinguish between "this is our nth year" and "we have n years of experience".',
    'Sending',
    'If your device has an internet connection while scouting, data should be sent to the spreadsheet as soon as it is submitted.',
    'Anything that hasn\'t been sent will be saved on the error logs, and can be loaded and uploaded on the Send screen whenever your device has an internet connection.',
    'Alternatively, if you need to send without an internet connection (this requires Android), make sure the paired device is running the app, and accept connections on that device before sending data.',
    'I think that pretty much covers it.', 'Have fun scouting!', 'Best wishes,', 'Harsh Tiwary']; // year-specific
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