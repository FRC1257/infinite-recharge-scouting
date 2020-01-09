import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

import 'useful.dart';

class Pit extends StatefulWidget {
  Pit ({Key key}) : super(key: key);
  @override
  PitState createState() => PitState();
}

class PitState extends State<Pit> {
  GlobalKey scaffold = GlobalKey();
  String event = '';
  String team = '';
  String role = '';
  String initials = '';
  String sandstorm = '';
  bool hatches = false;
  String speed = '';
  String weight = '';
  bool vision = false;
  String drivetrain = '';
  String hatchMech = '';
  String cargoMech = '';
  String climbMech = '';
  String helpMech = '';
  String experience = '';
  String notes = '';
  Boolean eventRed = Boolean(false);
  Boolean teamRed = Boolean(false);
  Boolean roleRed = Boolean(false);
  Boolean initialsRed = Boolean(false);
  Boolean sandstormRed = Boolean(false);
  Boolean speedRed = Boolean(false);
  Boolean weightRed = Boolean(false);
  Boolean drivetrainRed = Boolean(false);
  Boolean hatchMechRed = Boolean(false);
  Boolean cargoMechRed = Boolean(false);
  Boolean climbMechRed = Boolean(false);
  Boolean helpMechRed = Boolean(false);
  Boolean experienceRed = Boolean(false);
  Boolean notesRed = Boolean(false);
  TextEditingController teamController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController initialsController = TextEditingController();
  TextEditingController speedController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController drivetrainController = TextEditingController();
  TextEditingController hatchMechController = TextEditingController();
  TextEditingController cargoMechController = TextEditingController();
  TextEditingController climbMechController = TextEditingController();
  TextEditingController helpMechController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  String ID = '';
  void reset() {
    setState(() {
      event = '';
      team = '';
      role = '';
      initials = '';
      sandstorm = '';
      speed = '';
      weight = '';
      drivetrain = '';
      hatchMech = '';
      cargoMech = '';
      climbMech = '';
      helpMech = '';
      experience = '';
      notes = '';
      teamController.clear();
      roleController.clear();
      initialsController.clear();
      initialsController.clear();
      speedController.clear();
      weightController.clear();
      drivetrainController.clear();
      hatchMechController.clear();
      cargoMechController.clear();
      climbMechController.clear();
      helpMechController.clear();
      experienceController.clear();
      notesController.clear();
      eventRed.makeFalse();
      teamRed.makeFalse();
      roleRed.makeFalse();
      initialsRed.makeFalse();
      sandstormRed.makeFalse();
      speedRed.makeFalse();
      weightRed.makeFalse();
      drivetrainRed.makeFalse();
      hatchMechRed.makeFalse();
      cargoMechRed.makeFalse();
      climbMechRed.makeFalse();
      helpMechRed.makeFalse();
      experienceRed.makeFalse();
      notesRed.makeFalse();
    });
  }
  Future<void> resetDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset information?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('All unsubmitted pit scouting information will be lost.'),
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
  Future<void> submitDialog() async {
    return showDialog<void>(
      context: scaffold.currentContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Submit information?'),
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
                setState(() {
                  List<String> criteria = [event, team, role, initials, sandstorm, speed, weight, drivetrain, hatchMech, cargoMech, climbMech, helpMech, experience, notes];
                  List<Boolean> bools = [eventRed, teamRed, roleRed, initialsRed, sandstormRed, speedRed, weightRed, drivetrainRed, hatchMechRed, cargoMechRed, climbMechRed, helpMechRed, experienceRed, notesRed];
                  for (int i = 0; i < criteria.length; i++) {
                    if (criteria[i] == '') {
                      flag = false;
                      bools[i].makeTrue();
                    } else {
                      bools[i].makeFalse();
                    }
                  }
                });
                if (flag) {
                  int millis = DateTime.now().millisecondsSinceEpoch;
                  String complete = '$event|$team|$role|$initials|$sandstorm|$hatches|$speed|$weight|$vision|$drivetrain|$hatchMech|$cargoMech|$climbMech|$helpMech|$experience|$notes|$millis|}';
                  int status = await makeRequest(ID, complete);
                  if (status == 200) {
                    Flushbar(
                        title:  'Send successful',
                        message:  'Information sent to spreadsheet',
                        duration:  Duration(seconds: 2),
                        icon: IconTheme(data: IconThemeData(color: Color(0xFF209020)), child: Icon(Icons.check_circle))
                    ).show(scaffold.currentContext);
                  } else {
                    if (status > 0) {
                      Flushbar(
                          title:  'Send unsuccessful',
                          message:  'HTTP error code $status',
                          duration:  Duration(seconds: 2),
                          icon: IconTheme(data: IconThemeData(color: Color(0xFF902020)), child: Icon(Icons.error))
                      ).show(scaffold.currentContext);
                    }
                    writeText('pitLogs', 'pitErrorLog.txt', complete, true);
                  }
                  writeText('pitLogs', 'pitLog.txt', complete, true);
                  Flushbar(
                      title:  'Save successful',
                      message:  'Match backed up on file system',
                      duration:  Duration(seconds: 2),
                      icon: IconTheme(data: IconThemeData(color: Color(0xFF209020)), child: Icon(Icons.check_circle))
                  ).show(scaffold.currentContext);
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
  @override
  void initState() {
    readText('settingsLogs', 'pid.txt').then((String id) {
      setState(() {
        ID = id;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        key: scaffold,
        body: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0.0, top: 12.0), child: Center(child: Text('Pit', style: TextStyle(fontSize: 22)))),
            Expanded(
              child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
                child: ListView(
                  children: <Widget>[
                    Row(
                        children: <Widget>[
                          Flexible(child: Center(child: Text('Event', style: TextStyle(color: eventRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 3, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Team', style: TextStyle(color: teamRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Role', style: TextStyle(color: roleRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
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
                                        controller: roleController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            role = newValue;
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
                          Flexible(child: Center(child: Text('Information', style: TextStyle(color: sandstormRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Front Hatches')), flex: 1, fit: FlexFit.tight),
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
                                        value: sandstorm,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            sandstorm = newValue;
                                          });
                                        },
                                        items: <String>['', 'Camera Feed', 'Autonomous', 'Blind'].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )
                                  ),
                                ),
                                flex: 1,
                                fit: FlexFit.tight
                            ),
                            Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Checkbox(
                                    value: hatches,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        hatches = newValue;
                                      });
                                    },
                                    activeColor: Color(0xFF97D700),
                                    checkColor: Color(0xFF51284F),
                                  )
                                ),
                                flex: 1,
                                fit: FlexFit.tight
                            ),
                          ]
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 8.0), child: Center(child: Text('Robot', style: TextStyle(fontSize: 18)))),
                    Row(
                        children: <Widget>[
                          Flexible(child: Center(child: Text('Speed', style: TextStyle(color: speedRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Weight', style: TextStyle(color: weightRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Vision')), flex: 1, fit: FlexFit.tight)
                        ]
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Row(
                          children: <Widget>[
                            Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: speedController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '...'
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          speed = newValue;
                                        });
                                      },
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
                                      controller: weightController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '...'
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          weight = newValue;
                                        });
                                      },
                                  ),
                                ),
                                flex: 1,
                                fit: FlexFit.tight
                            ),
                            Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Checkbox(
                                    value: vision,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        vision = newValue;
                                      });
                                    },
                                    activeColor: Color(0xFF97D700),
                                    checkColor: Color(0xFF51284F),
                                  )
                                ),
                                flex: 1,
                                fit: FlexFit.tight
                            )
                          ]
                      ),
                    ),
                    Row(
                        children: <Widget>[
                          Flexible(child: Center(child: Text('Drivetrain (type, # motors, motor type)', style: TextStyle(color: drivetrainRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight)
                        ]
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Row(
                          children: <Widget>[
                            Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: drivetrainController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '...'
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          drivetrain = newValue;
                                        });
                                      },
                                  ),
                                ),
                                flex: 1,
                                fit: FlexFit.tight
                            ),
                          ]
                      ),
                    ),
                    Row(
                        children: <Widget>[
                          Flexible(child: Center(child: Text('Hatch Mechanism', style: TextStyle(color: hatchMechRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Cargo Mechanism', style: TextStyle(color: cargoMechRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight)
                        ]
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Row(
                          children: <Widget>[
                            Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: hatchMechController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '...'
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          hatchMech = newValue;
                                        });
                                      },
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
                                      controller: cargoMechController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '...'
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          cargoMech = newValue;
                                        });
                                      },
                                  ),
                                ),
                                flex: 1,
                                fit: FlexFit.tight
                            ),
                          ]
                      ),
                    ),
                    Row(
                        children: <Widget>[
                          Flexible(child: Center(child: Text('Climb Mechanism', style: TextStyle(color: climbMechRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Help Mechanism', style: TextStyle(color: hatchMechRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight)
                        ]
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Row(
                          children: <Widget>[
                            Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: climbMechController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '...'
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        climbMech = newValue;
                                      });
                                    },
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
                                    controller: helpMechController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '...'
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        helpMech = newValue;
                                      });
                                    },
                                  ),
                                ),
                                flex: 1,
                                fit: FlexFit.tight
                            ),
                          ]
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 8.0), child: Center(child: Text('Drive Team Experience', style: TextStyle(fontSize: 18, color: experienceRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF))))),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Row(
                          children: <Widget>[
                            Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: experienceController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '...'
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        experience = newValue;
                                      });
                                    },
                                  ),
                                ),
                                flex: 1,
                                fit: FlexFit.tight
                            ),
                          ]
                      ),
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
                                          hintText: 'Note willingness to do defense, match strategy, etc.'
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
                                  flex: 1,
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
          ]
        )
    );
  }
}