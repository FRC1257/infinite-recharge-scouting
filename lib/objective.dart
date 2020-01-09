// Comments like these will precede each block of code.
// They are intended to provide the purpose for each part
// of the general, ideally constant structure, and how to
// apply it to future years of scouting apps. The instructions
// for each block of code assume a constant code structure, but it is
// not for me to say that this will happen (it probably won't). After all,
// improvements can always, and should always, be made. The comments are
// addressed to the people who will be modifying the 1257 app in the future
// as this rebuild was both a starting point for Flutter and a half-template,
// half-example for future scouting apps. Note that the comments made for the
// objective page also generally apply to the pit page, as there is nothing
// in the pit page that isn't in the objective page.
// - Harsh Tiwary, 2019

// These import statements are necessary for getting the methods
// in built-in packages specified in pubspec.yaml, core dart methods,
// and other dart files in this project.
// Leave them unchanged.
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

import 'useful.dart';

// The following class is necessary for creating a stateful widget (a widget whose state changes).
class Objective extends StatefulWidget {
  Objective ({Key key}) : super(key: key);
  @override
  ObjectiveState createState() => ObjectiveState();
}

class ObjectiveState extends State<Objective> { // This is the state of the widget (i.e. its backbone).
  // This GlobalKey is to make sure that the context (widget location reference)
  // of Scaffold (the main framework) is passed to other methods for status updates.
  // It stays unchanged.
  GlobalKey scaffold = GlobalKey();
  // The following are the data points that hold the values entered in by fields.
  // Declare them here.
  String event = '';
  String team = '';
  String match = '';
  String initials = '';
  String sandstormStart = '';
  String sandstormPreload = '';
  String sandstormHatch= '';
  String sandstormCargo= '';
  int hatchShip = 0;
  int hatchLow = 0;
  int hatchMedium = 0;
  int hatchHigh = 0;
  int hatchDropped = 0;
  int cargoShip = 0;
  int cargoLow = 0;
  int cargoMedium = 0;
  int cargoHigh = 0;
  int cargoDropped = 0;
  String endgameClimb = '';
  String endgameHelp = '';
  String notes = '';
  // These Booleans (custom boolean class passed by reference) determine for each REQUIRED field
  // if they need to be filled in and are not. This determines whether the labels are red.
  // Declare them for all required fields as shown here.
  Boolean eventRed = Boolean(false);
  Boolean teamRed = Boolean(false);
  Boolean matchRed = Boolean(false);
  Boolean initialsRed = Boolean(false);
  Boolean sandstormStartRed = Boolean(false);
  Boolean sandstormPreloadRed = Boolean(false);
  Boolean sandstormHatchRed = Boolean(false);
  Boolean sandstormCargoRed = Boolean(false);
  Boolean endgameClimbRed = Boolean(false);
  Boolean endgameHelpRed = Boolean(false);
  Boolean notesRed = Boolean(false);
  // These TextEditingControllers have to be declared to
  // set the state for text fields each time a change occurs.
  // Declare them for all text fields as shown here.
  TextEditingController teamController = TextEditingController();
  TextEditingController matchController = TextEditingController();
  TextEditingController initialsController = TextEditingController();
  TextEditingController sandstormHatchController = TextEditingController();
  TextEditingController sandstormCargoController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  // These variables (robot to scout and objective ID) are determined by the
  // settings logs and must be set in the asynchronous methods below to read said logs.
  // Leave them unchanged.
  String text = '';
  String ID = '';
  // The reset method clears all variables and sets the TextEditingControllers
  // to clear their fields. It also clears the Booleans, making all labels white.
  // Implement it for all data points, TextEditingControllers, and Booleans as shown here.
  void reset() {
    setState(() {
      event = '';
      team = '';
      match = '';
      initials = '';
      sandstormStart = '';
      sandstormPreload = '';
      sandstormHatch = '';
      sandstormCargo = '';
      hatchShip = 0;
      hatchLow = 0;
      hatchMedium = 0;
      hatchHigh = 0;
      hatchDropped = 0;
      cargoShip = 0;
      cargoLow = 0;
      cargoMedium = 0;
      cargoHigh = 0;
      cargoDropped = 0;
      endgameClimb = '';
      endgameHelp = '';
      notes = '';
      teamController.clear();
      matchController.clear();
      initialsController.clear();
      sandstormHatchController.clear();
      sandstormCargoController.clear();
      notesController.clear();
      eventRed.makeFalse();
      teamRed.makeFalse();
      matchRed.makeFalse();
      initialsRed.makeFalse();
      sandstormStartRed.makeFalse();
      sandstormPreloadRed.makeFalse();
      sandstormHatchRed.makeFalse();
      sandstormCargoRed.makeFalse();
      endgameClimbRed.makeFalse();
      endgameHelpRed.makeFalse();
      notesRed.makeFalse();
    });
  }
  // This reset dialog code calls the reset function if desired, but gives the
  // user an option to back out if they clicked it by accident.
  // Leave it unchanged.
  Future<void> resetDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset match?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('All unsubmitted objective scouting information will be lost.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(scaffold.currentContext).pop();
                reset();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(scaffold.currentContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
  // The first part of this method, before the setState, does the same and sets up
  // the dialog to confirm submission of the data gathered per match.
  // Leave it unchanged.
  Future<void> submitDialog() async {
    return showDialog<void>(
      context: scaffold.currentContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Submit match?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You will not be able to change submitted scouting data.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () async {
                Navigator.of(scaffold.currentContext).pop();
                bool flag = true;
                // This following setState uses a list of data points and their labels to color
                // the labels of unfilled fields (checked by whether the data point is empty).
                // Implement it with the required data points and Booleans you declared above.
                setState(() {
                  List<String> criteria = [event, team, match, initials, sandstormStart, sandstormPreload, sandstormHatch, sandstormCargo, endgameClimb, endgameHelp, notes];
                  List<Boolean> bools = [eventRed, teamRed, matchRed, initialsRed, sandstormStartRed, sandstormPreloadRed, sandstormHatchRed, sandstormCargoRed, endgameClimbRed, endgameHelpRed, notesRed];
                  for (int i = 0; i < criteria.length; i++) {
                    if (criteria[i] == '') {
                      flag = false;
                      bools[i].makeTrue();
                    } else {
                      bools[i].makeFalse();
                    }
                  }
                });
                // The following, which is if the data is complete, makes sure the match value is uniform
                // (whether it is 59 or q59 or Q59, or an eliminations match code like QF2m2 or sf1M3).
                // Leave it unchanged.
                if (flag) {
                  match = match.toUpperCase();
                  bool quals = false;
                  if (((!(match[0] == 'S')) && (!(match[0] == 'F'))) && (!((match[0] == 'Q') && (match[1] == 'F')))) {
                    quals = true;
                  }
                  if ((match[0] != 'Q') && (quals == true)) {
                    match = 'Q' + match;
                  }
                  // The following constructs and interprets the success of the web request.
                  // Change the construction of the complete string based on your data points, but
                  // leave everything else unchanged.
                  int millis = DateTime.now().millisecondsSinceEpoch;
                  String complete = '$event|$team|$match|$initials|$sandstormStart|$sandstormPreload|$sandstormHatch|$sandstormCargo|$cargoHigh|$cargoMedium|$cargoLow|$cargoShip|$cargoDropped|$hatchHigh|$hatchMedium|$hatchLow|$hatchShip|$hatchDropped|$endgameClimb|$endgameHelp|$notes|$millis|}';
                  int status = await makeRequest(ID, complete);
                  if (status == 200) {
                    Flushbar(
                        title:  'Send successful',
                        message:  'Match sent to spreadsheet',
                        duration:  Duration(seconds: 2),
                        icon: IconTheme(data: IconThemeData(color: Color(0xFF209020)), child: Icon(Icons.check_circle))
                    ).show(scaffold.currentContext);
                  } else {
                    writeText('objectiveLogs', 'objectiveErrorLog.txt', complete, true);
                    Flushbar(
                        title:  'Save successful',
                        message:  'Match backed up on file system',
                        duration:  Duration(seconds: 2),
                        icon: IconTheme(data: IconThemeData(color: Color(0xFF209020)), child: Icon(Icons.check_circle))
                    ).show(scaffold.currentContext);
                  }
                  writeText('objectiveLogs', 'objectiveLog.txt', complete, true);

                  reset();
                  // This is the response for if the data is not complete.
                  // Leave it unchanged.
                } else {
                  Flushbar(
                    title:  'Submit unsuccessful',
                    message:  'Please fill out all required fields before submitting',
                    duration:  Duration(seconds: 2),
                    icon: IconTheme(data: IconThemeData(color: Color(0xFF902020)), child: Icon(Icons.error))
                  ).show(scaffold.currentContext);
                }
              },
            ),
            // This is just the "no" option.
            // Leave it unchanged.
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(scaffold.currentContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
  // The following sets the above robot-to-scout and objective ID values.
  // Leave it unchanged.
  @override
  void initState() {
    readText('settingsLogs', 'robot.txt').then((String txt) {
      setState(() {
        text = txt;
      });
    });
    readText('settingsLogs', 'oid.txt').then((String id) {
      setState(() {
        ID = id;
      });
    });
    super.initState();
  }
  // I'm not going to comment on every code sample here, as it is expansive and quite
  // flexible (no pun intended) However, for layout purposes, I will outline the
  // intended guideline for the structure of the screen.
  // The code I use for padding should be fairly obvious, as it's there in the build method.
  // HEADER: padding (L8R8T12B0), with center with title
  // BODY: expanded, with child padding (V8), with ListView (scroller)
  // EACH BLOCK in ListView: either a label row, widget row, or heading row
  // LABEL ROW: flexed centered sets of labels
  // WIDGET ROW: flexed centered sets of H8 padding (with each widget as a child), all in a B8 padding
  // HEADING ROW: center with heading in a B8 padding
  // The exception is reset and submit, which have L8R4 and L4R8 paddings respectively all in B8 padding
  // Note that this is all just layout instruction, you can change it up to your ideal but make sure
  // it's elegant, and not skewed/asymmetric/jank, because that distracts users from the app's
  // intuitiveness, making it harder to use. Try to be somewhat perfectionistic with it.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
      // The following key line is not part of the structure but put in here to specify the GlobalKey above.
      // Leave it unchanged.
        key: scaffold,
        body: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0.0, top: 12.0), child: Center(child: Text('Objective', style: TextStyle(fontSize: 22)))),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListView(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(bottom: 8.0, top: 4.0), child: Center(child: Text('Scout this robot: $text', style: TextStyle(fontSize: 18)))),
                          Row(
                              children: <Widget>[
                                Flexible(child: Center(child: Text('Event', style: TextStyle(color: eventRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 3, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Team', style: TextStyle(color: teamRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Match', style: TextStyle(color: matchRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Initials', style: TextStyle(color: initialsRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight)
                              ]
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: event,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    event = newValue;
                                                  });
                                                },
                                                items: <String>['', 'Training', 'BE'].map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              )
                                          ),
                                        ),
                                        flex: 3,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: TextField(
                                              textAlign: TextAlign.center,
                                              controller: teamController,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '...'
                                              ),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  team = newValue;
                                                });
                                              },
                                              keyboardType: TextInputType.number
                                          ),
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: TextField(
                                              textAlign: TextAlign.center,
                                              controller: matchController,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '...'
                                              ),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  match = newValue;
                                                });
                                              }
                                          ),
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: TextField(
                                              textAlign: TextAlign.center,
                                              controller: initialsController,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '...'
                                              ),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  initials = newValue;
                                                });
                                              }
                                          ),
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 8.0), child: Center(child: Text('Sandstorm', style: TextStyle(fontSize: 18)))),
                          Row(
                              children: <Widget>[
                                Flexible(child: Center(child: Text('Start', style: TextStyle(color: sandstormStartRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 3, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Preload', style: TextStyle(color: sandstormPreloadRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 3, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Hatch', style: TextStyle(color: sandstormHatchRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 2, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Cargo', style: TextStyle(color: sandstormCargoRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 2, fit: FlexFit.tight)
                              ]
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Row(
                                children: <Widget>[
                                  Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: sandstormStart,
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  sandstormStart = newValue;
                                                });
                                              },
                                              items: <String>['', 'None', 'L1', 'L2'].map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            )
                                        ),
                                      ),
                                      flex: 3,
                                      fit: FlexFit.tight
                                  ),
                                  Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: sandstormPreload,
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  sandstormPreload = newValue;
                                                });
                                              },
                                              items: <String>['', 'None', 'Hatch', 'Cargo'].map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            )
                                        ),
                                      ),
                                      flex: 3,
                                      fit: FlexFit.tight
                                  ),
                                  Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                        child: TextField(
                                            textAlign: TextAlign.center,
                                            controller: sandstormHatchController,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: '...'
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                sandstormHatch = newValue;
                                              });
                                            },
                                            keyboardType: TextInputType.number
                                        ),
                                      ),
                                      flex: 2,
                                      fit: FlexFit.tight
                                  ),
                                  Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                        child: TextField(
                                            textAlign: TextAlign.center,
                                            controller: sandstormCargoController,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: '...'
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                sandstormCargo = newValue;
                                              });
                                            },
                                            keyboardType: TextInputType.number
                                        ),
                                      ),
                                      flex: 2,
                                      fit: FlexFit.tight
                                  ),
                                ]
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 8.0), child: Center(child: Text('Hatch', style: TextStyle(fontSize: 18)))),
                          Row(
                              children: <Widget>[
                                Flexible(child: Center(child: Text('Cargo')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Low')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Medium')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('High')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Dropped')), flex: 1, fit: FlexFit.tight)
                              ]
                          ),
                          Row(
                              children: <Widget>[
                                Flexible(child: Center(child: Text('Ship')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Rocket')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Rocket')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Rocket')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('on Field')), flex: 1, fit: FlexFit.tight)
                              ]
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchShip++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchLow++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchMedium++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchHigh++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchDropped++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: Center(child: Text('$hatchShip')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$hatchLow')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$hatchMedium')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$hatchHigh')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$hatchDropped')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchShip = max(0, hatchShip - 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchLow= max(0, hatchLow- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchMedium= max(0, hatchMedium- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchHigh= max(0, hatchHigh- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchDropped = max(0, hatchDropped- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 8.0), child: Center(child: Text('Cargo', style: TextStyle(fontSize: 18)))),
                          Row(
                              children: <Widget>[
                                Flexible(child: Center(child: Text('Cargo')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Low')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Medium')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('High')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Dropped')), flex: 1, fit: FlexFit.tight)
                              ]
                          ),
                          Row(
                              children: <Widget>[
                                Flexible(child: Center(child: Text('Ship')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Rocket')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Rocket')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Rocket')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('on Field')), flex: 1, fit: FlexFit.tight)
                              ]
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoShip++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoLow++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoMedium++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoHigh++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoDropped++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: Center(child: Text('$cargoShip')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$cargoLow')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$cargoMedium')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$cargoHigh')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$cargoDropped')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoShip = max(0, cargoShip - 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoLow= max(0, cargoLow- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoMedium= max(0, cargoMedium- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoHigh= max(0, cargoHigh- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoDropped = max(0, cargoDropped- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 8.0), child: Center(child: Text('Endgame', style: TextStyle(fontSize: 18)))),
                          Row(
                              children: <Widget>[
                                Flexible(child: Center(child: Text('Climb', style: TextStyle(color: endgameClimbRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Help', style: TextStyle(color: endgameHelpRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight)
                              ]
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: endgameClimb,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    endgameClimb = newValue;
                                                  });
                                                },
                                                items: <String>['', 'None', 'L1', 'L2', 'L3'].map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              )
                                          ),
                                        ),
                                        flex: 3,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: endgameHelp,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    endgameHelp = newValue;
                                                  });
                                                },
                                                items: <String>['', 'None', 'Received', 'L2', 'L3', 'L2/L2', 'L2/L3', 'L3/L3'].map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              )
                                          ),
                                        ),
                                        flex: 3,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 8.0), child: Center(child: Text('Notes', style: TextStyle(fontSize: 18, color: notesRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF))))),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: TextField(
                                            controller: notesController,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Note malfunctions, fouls, driving, intake, speed, etc.'
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                notes = newValue;
                                              });
                                            },
                                            keyboardType: TextInputType.multiline,
                                            maxLines: null,
                                          ),
                                        ),
                                        flex: 3,
                                        fit: FlexFit.tight
                                    )
                                  ]
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: Padding(
                                            padding: EdgeInsets.only(left: 8.0, right: 4.0),
                                            child: RaisedButton(
                                                child: Text('Reset'),
                                                color: Color(0xFF97D700),
                                                textColor: Color(0xFF51284F),
                                                onPressed: resetDialog
                                            )
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Padding(
                                            padding: EdgeInsets.only(left: 4.0, right: 8.0),
                                            child: RaisedButton(
                                                child: Text('Submit'),
                                                color: Color(0xFF97D700),
                                                textColor: Color(0xFF51284F),
                                                onPressed: submitDialog
                                            ),
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    )
                                  ]
                              )
                          ),
                        ]
                    )
                )
            )
          ],
        )
    );
  }
}