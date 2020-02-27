import 'package:flutter_for_web/material.dart';

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
  String drivetrainType = '';
  String drivetrainMotorNumber = '';
  String drivetrainMotorType = '';
  String speed = '';
  String weight = '';
  String height = '';
  String vision = '';
  String capacity = '';
  String lang = '';
  String cellMech = '';
  String cellReliability = '';
  String cellTime = '';
  String panelMech = '';
  String panelReliability = '';
  String panelTime = '';
  String climbMech = '';
  String climbReliability = '';
  String climbTime = '';
  String experience = '';
  String notes = '';
  Boolean eventRed = Boolean(false);
  Boolean teamRed = Boolean(false);
  Boolean roleRed = Boolean(false);
  Boolean initialsRed = Boolean(false);
  Boolean drivetrainTypeRed = Boolean(false);
  Boolean drivetrainMotorNumberRed = Boolean(false);
  Boolean drivetrainMotorTypeRed = Boolean(false);
  Boolean speedRed = Boolean(false);
  Boolean weightRed = Boolean(false);
  Boolean heightRed = Boolean(false);
  Boolean visionRed = Boolean(false);
  Boolean capacityRed = Boolean(false);
  Boolean langRed = Boolean(false);
  Boolean cellMechRed = Boolean(false);
  Boolean cellReliabilityRed = Boolean(false);
  Boolean cellTimeRed = Boolean(false);
  Boolean panelMechRed = Boolean(false);
  Boolean panelReliabilityRed = Boolean(false);
  Boolean panelTimeRed = Boolean(false);
  Boolean climbMechRed = Boolean(false);
  Boolean climbReliabilityRed = Boolean(false);
  Boolean climbTimeRed = Boolean(false);
  Boolean experienceRed = Boolean(false);
  Boolean notesRed = Boolean(false);
  TextEditingController teamController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController initialsController = TextEditingController();
  TextEditingController drivetrainTypeController = TextEditingController();
  TextEditingController drivetrainMotorNumberController = TextEditingController();
  TextEditingController drivetrainMotorTypeController = TextEditingController();
  TextEditingController speedController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController langController = TextEditingController();
  TextEditingController cellMechController = TextEditingController();
  TextEditingController cellReliabilityController = TextEditingController();
  TextEditingController cellTimeController = TextEditingController();
  TextEditingController panelMechController = TextEditingController();
  TextEditingController panelReliabilityController = TextEditingController();
  TextEditingController panelTimeController = TextEditingController();
  TextEditingController climbMechController = TextEditingController();
  TextEditingController climbReliabilityController = TextEditingController();
  TextEditingController climbTimeController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  String ID = '1FAIpQLScwlPN0XZVUgJ2vJkyiJbG-5aunUgqkIvfoiMRKgNIKTt7hsg/formResponse?usp=pp_url&entry.857213824';
  void reset() {
    setState(() {
      event = '';
      team = '';
      role = '';
      initials = '';
      drivetrainType = '';
      drivetrainMotorNumber = '';
      drivetrainMotorType = '';
      speed = '';
      weight = '';
      height = '';
      vision = '';
      capacity = '';
      lang = '';
      cellMech = '';
      cellReliability = '';
      cellTime = '';
      panelMech = '';
      panelReliability = '';
      panelTime = '';
      climbMech = '';
      climbReliability = '';
      climbTime = '';
      experience = '';
      notes = '';
      teamController.clear();
      roleController.clear();
      initialsController.clear();
      drivetrainTypeController.clear();
      drivetrainMotorNumberController.clear();
      drivetrainMotorTypeController.clear();
      speedController.clear();
      weightController.clear();
      heightController.clear();
      capacityController.clear();
      langController.clear();
      cellMechController.clear();
      cellReliabilityController.clear();
      cellTimeController.clear();
      panelMechController.clear();
      panelReliabilityController.clear();
      panelTimeController.clear();
      climbMechController.clear();
      climbReliabilityController.clear();
      climbTimeController.clear();
      experienceController.clear();
      notesController.clear();
      eventRed.makeFalse();
      teamRed.makeFalse();
      roleRed.makeFalse();
      initialsRed.makeFalse();
      drivetrainTypeRed.makeFalse();
      drivetrainMotorNumberRed.makeFalse();
      drivetrainMotorTypeRed.makeFalse();
      speedRed.makeFalse();
      weightRed.makeFalse();
      heightRed.makeFalse();
      visionRed.makeFalse();
      capacityRed.makeFalse();
      langRed.makeFalse();
      cellMechRed.makeFalse();
      cellReliabilityRed.makeFalse();
      cellTimeRed.makeFalse();
      panelMechRed.makeFalse();
      panelReliabilityRed.makeFalse();
      panelTimeRed.makeFalse();
      climbMechRed.makeFalse();
      climbReliabilityRed.makeFalse();
      climbTimeRed.makeFalse();
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
                  List<String> criteria = [event, team, role, initials, drivetrainType, drivetrainMotorNumber, drivetrainMotorType, speed, weight, height, vision, capacity, lang, cellMech, cellReliability, cellTime, panelMech, panelReliability, panelTime, climbMech, climbReliability, climbTime, experience, notes];
                  List<Boolean> bools = [eventRed, teamRed, roleRed, initialsRed, drivetrainTypeRed, drivetrainMotorNumberRed, drivetrainMotorTypeRed, speedRed, weightRed, heightRed, visionRed, capacityRed, langRed, cellMechRed, cellReliabilityRed, cellTimeRed, panelMechRed, panelReliabilityRed, panelTimeRed, climbMechRed, climbReliabilityRed, climbTimeRed, experienceRed, notesRed];
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
                  String complete = '$event|$team|$role|$initials|$drivetrainType|$drivetrainMotorNumber|$drivetrainMotorType|$speed|$weight|$height|$vision|$capacity|$lang|$cellMech|$cellReliability|$cellTime|$panelMech|$panelReliability|$panelTime|$climbMech|$climbReliability|$climbTime|$experience|$notes|$millis|}';
                  int status = await makeRequest(ID, complete);
                  reset();
                  // This is the response for if the data is not complete.
                  // Leave it unchanged.
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
                                    )
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
                    Padding(padding: EdgeInsets.only(bottom: 8.0), child: Center(child: Text('Drivetrain', style: TextStyle(fontSize: 18)))),
                    Row(
                        children: <Widget>[
                          Flexible(child: Center(child: Text('Type', style: TextStyle(color: drivetrainTypeRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Number of Motors', style: TextStyle(color: drivetrainMotorNumberRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Motor Type', style: TextStyle(color: drivetrainMotorTypeRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight)
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
                                        controller: drivetrainTypeController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            drivetrainType = newValue;
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
                                        controller: drivetrainMotorNumberController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            drivetrainMotorNumber = newValue;
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
                                        controller: drivetrainMotorTypeController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            drivetrainMotorType = newValue;
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
                    Padding(padding: EdgeInsets.only(bottom: 8.0), child: Center(child: Text('General', style: TextStyle(fontSize: 18)))),
                    Row(
                        children: <Widget>[
                          Flexible(child: Center(child: Text('Speed', style: TextStyle(color: speedRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Weight', style: TextStyle(color: weightRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Height', style: TextStyle(color: heightRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Vision', style: TextStyle(color: visionRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight)
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
                                        controller: heightController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            height = newValue;
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
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: vision,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              vision = newValue;
                                            });
                                          },
                                          items: <String>['', 'Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        )
                                    )
                                  ),
                                  flex: 1,
                                  fit: FlexFit.tight
                              ),
                            ]
                        )
                    ),
                    Row(
                        children: <Widget>[
                          Flexible(child: Center(child: Text('Capacity', style: TextStyle(color: capacityRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Programming Language', style: TextStyle(color: langRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
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
                                        controller: capacityController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            capacity = newValue;
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
                                        controller: langController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            lang = newValue;
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
                    Padding(padding: EdgeInsets.only(bottom: 8.0), child: Center(child: Text('Mechanisms', style: TextStyle(fontSize: 18)))),
                    Row(
                        children: <Widget>[
                          Flexible(child: Center(child: Text('Power Cell', style: TextStyle(color: cellMechRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Control Panel', style: TextStyle(color: panelMechRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Climb/Level', style: TextStyle(color: climbMechRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
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
                                        controller: cellMechController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            cellMech = newValue;
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
                                        controller: panelMechController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            panelMech = newValue;
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
                                        controller: climbMechController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            climbMech = newValue;
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
                    Row(
                        children: <Widget>[
                          Flexible(child: Center(child: Text('Cell Reliability', style: TextStyle(color: cellReliabilityRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Panel Reliability', style: TextStyle(color: panelReliabilityRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Climb Reliability', style: TextStyle(color: climbReliabilityRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
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
                                        controller: cellReliabilityController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            cellReliability = newValue;
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
                                        controller: panelReliabilityController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            panelReliability = newValue;
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
                                        controller: climbReliabilityController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            climbReliability = newValue;
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
                    Row(
                        children: <Widget>[
                          Flexible(child: Center(child: Text('Cell Time', style: TextStyle(color: cellTimeRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Panel Time', style: TextStyle(color: panelTimeRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                          Flexible(child: Center(child: Text('Climb Time', style: TextStyle(color: climbTimeRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
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
                                        controller: cellTimeController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            cellTime = newValue;
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
                                        controller: panelTimeController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            panelTime = newValue;
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
                                        controller: climbTimeController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            climbTime = newValue;
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