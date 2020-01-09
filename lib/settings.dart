import 'package:flutter/material.dart';

import 'useful.dart';

class Settings extends StatefulWidget {
  Settings ({Key key}) : super(key: key);
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  String robot = '';
  String objectiveID = '';
  String pitID = '';
  TextEditingController oidController = TextEditingController();
  TextEditingController pidController = TextEditingController();
  @override
  void initState() {
    readText('settingsLogs', 'team.txt').then((String tm) {
      setState(() {
        if ((tm == '') || (tm == null)) {
          tm = '1257';
          writeText('settingsLogs', 'team.txt', tm, false);
        }
      });
    });
    readText('settingsLogs', 'robot.txt').then((String rbt) {
      setState(() {
        if ((rbt == '') || (rbt == null)) {
          rbt = 'Nearest Red';
          writeText('settingsLogs', 'robot.txt', rbt, false);
        }
        robot = rbt;
      });
    });
    readText('settingsLogs', 'oid.txt').then((String oid) {
      setState(() {
        if ((oid == '') || (oid == null)) {
          oid = '1FAIpQLSd576eCt6nkJw0oHGq0vO4vg-MysOsgl_XLs2bbCAP8LmYB5Q';
          writeText('settingsLogs', 'oid.txt', oid, false);
        }
        objectiveID = oid;
        oidController.text = objectiveID;
      });
    });
    readText('settingsLogs', 'pid.txt').then((String pid) {
      setState(() {
        if ((pid == '') || (pid == null)) {
          pid = '1Ak6eePtfBNeRiirdBNp8R7jAu2uxjrTve2DBVRKbbaQ';
          writeText('settingsLogs', 'pid.txt', pid, false);
        }
        pitID = pid;
        pidController.text = pitID;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0.0, top: 12.0), child: Center(child: Text('Settings', style: TextStyle(fontSize: 22)))),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListView(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Center(child: Text('Robot to scout: '))
                                ),
                                flex: 1,
                                fit: FlexFit.tight
                            ),
                            Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: robot,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            robot = newValue;
                                            writeText('settingsLogs', 'robot.txt', robot, false);
                                          });
                                        },
                                        items: <String>['Nearest Red', 'Middle Red', 'Farthest Red', 'Nearest Blue', 'Middle Blue', 'Farthest Blue'].map<DropdownMenuItem<String>>((String value) {
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
                        ),
                        Row(
                            children: <Widget>[
                              Flexible(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Center(child: Text('Objective ID: '))
                                  ),
                                  flex: 1,
                                  fit: FlexFit.tight
                              ),
                              Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      controller: oidController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          objectiveID = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                  flex: 2,
                                  fit: FlexFit.tight
                              ),
                              Flexible(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: RaisedButton(
                                          child: Text('Save'),
                                          color: Color(0xFF97D700),
                                          textColor: Color(0xFF51284F),
                                          onPressed: () => writeText('settingsLogs', 'oid.txt', objectiveID, false)
                                      )
                                  ),
                                  flex: 1,
                                  fit: FlexFit.tight
                              ),
                            ]
                        ),
                        Row(
                            children: <Widget>[
                              Flexible(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Center(child: Text('Pit ID: '))
                                  ),
                                  flex: 1,
                                  fit: FlexFit.tight
                              ),
                              Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      controller: pidController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          pitID = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                  flex: 2,
                                  fit: FlexFit.tight
                              ),
                              Flexible(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: RaisedButton(
                                          child: Text('Save'),
                                          color: Color(0xFF97D700),
                                          textColor: Color(0xFF51284F),
                                          onPressed: () => writeText('settingsLogs', 'pid.txt', pitID, false)
                                      )
                                  ),
                                  flex: 1,
                                  fit: FlexFit.tight
                              ),
                            ]
                        ),
                      ]
                  )
              )
          )
        ],
      ),
    );
  }
}