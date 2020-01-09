import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flushbar/flushbar.dart';

import 'useful.dart';

class Send extends StatefulWidget {
  Send ({Key key}) : super(key: key);
  @override
  SendState createState() => SendState();
}

class SendState extends State<Send> {
  static const platform = const MethodChannel('org.team1257.deepspacescouting/send');
  GlobalKey scaffold = GlobalKey();
  String dataType = 'Objective';
  String logType = 'Error';
  String lastData = 'Objective';
  String data = '';
  String OID;
  String PID;
  String dev = '';
  List<dynamic> devs = <dynamic>[];
  TextEditingController dataController = new TextEditingController();
  @override
  void initState() {
    readText('settingsLogs', 'oid.txt').then((String id) {
      setState(() {
        OID = id;
      });
    });
    readText('settingsLogs', 'pid.txt').then((String id) {
      setState(() {
        PID = id;
      });
    });
    getDeviceNames();
    platform.setMethodCallHandler(handleAccept);
    super.initState();
  }
  Future<dynamic> handleAccept(MethodCall call) async {
    if (call.method == 'accept') {
      dataController.text = call.arguments;
      return new Future.value(data);
    }
  }
  void getDeviceNames() async {
    try {
      devs = await platform.invokeMethod('getDeviceNames');
      dev = devs[0];
    } on PlatformException catch (e) {
      Flushbar(
          title:  'Device listing unsuccessful',
          message:  'Cannot get Bluetooth device list: ${e.message}',
          duration:  Duration(seconds: 2),
          icon: IconTheme(data: IconThemeData(color: Color(0xFF902020)), child: Icon(Icons.error))
      ).show(scaffold.currentContext);
    }
  }
  void load() async {
    String mLog = logType == 'Complete' ? "" : logType;
    String newData = await readText('${dataType.toLowerCase()}Logs', '${dataType.toLowerCase()}${mLog}Log.txt');
    setState(() {
      data = newData;
      dataController.text = data;
    });
    lastData = dataType;
  }
  void upload() async {
    List<String> matches = data.split("\\}");
    while (matches.length > 0) {
      String finalString = "";
      while ((finalString.length < 1000) && (matches.length > 0)) {
        finalString += matches[0] + "}";
        matches.remove(matches[0]);
      }
      int status;
      if (lastData == 'Objective') {
        status = await makeRequest(OID, finalString);
      } else {
        status = await makeRequest(PID, finalString);
      }
      if (status == 200) {
        Flushbar(
            title:  'Upload successful',
            message:  'Data sent to spreadsheet',
            duration:  Duration(seconds: 2),
            icon: IconTheme(data: IconThemeData(color: Color(0xFF209020)), child: Icon(Icons.check_circle))
        ).show(scaffold.currentContext);
        writeText('${lastData.toLowerCase()}Logs', '${lastData.toLowerCase()}ErrorLog.txt', '', false);
      } else {
        if (status > 0) {
          Flushbar(
              title:  'Upload unsuccessful',
              message:  'HTTP error code $status',
              duration:  Duration(seconds: 2),
              icon: IconTheme(data: IconThemeData(color: Color(0xFF902020)), child: Icon(Icons.error))
          ).show(scaffold.currentContext);
        } else {
          Flushbar(
              title:  'Upload unsuccessful',
              message:  'No connection',
              duration:  Duration(seconds: 2),
              icon: IconTheme(data: IconThemeData(color: Color(0xFF902020)), child: Icon(Icons.error))
          ).show(scaffold.currentContext);
        }
      }
    }
  }
  Future<String> acceptDialog() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Accept connections?'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dev,
                          onChanged: (String newValue) {
                            setState(() {
                              dev = newValue;
                            });
                          },
                          items: devs.cast<String>().toList().map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(scaffold.currentContext).pop();
                    accept();
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
          });
      },
    );
    return dev;
  }
  void accept() async {
    try {
      data = await platform.invokeMethod('acceptConnections', {'name': dev});
    } on PlatformException catch (e) {
      Flushbar(
          title:  'Accept unsuccessful',
          message:  '${e.message}',
          duration:  Duration(seconds: 2),
          icon: IconTheme(data: IconThemeData(color: Color(0xFF902020)), child: Icon(Icons.error))
      ).show(scaffold.currentContext);
    }
  }
  Future<String> sendDialog() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Send data?'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dev,
                            onChanged: (String newValue) {
                              setState(() {
                                dev = newValue;
                              });
                            },
                            items: devs.cast<String>().toList().map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.of(scaffold.currentContext).pop();
                      send();
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
            });
      },
    );
    return dev;
  }
  void send() async {
    try {
      platform.invokeMethod('sendData', {'name': dev, 'data': data});
    } on PlatformException catch (e) {
      Flushbar(
          title:  'Send unsuccessful',
          message:  '${e.message}',
          duration:  Duration(seconds: 2),
          icon: IconTheme(data: IconThemeData(color: Color(0xFF902020)), child: Icon(Icons.error))
      ).show(scaffold.currentContext);
    }
  }
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Scaffold(
          backgroundColor: Colors.transparent,
          key: scaffold,
          body: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0.0, top: 12.0), child: Center(child: Text('Send', style: TextStyle(fontSize: 22)))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListView(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Center(child: Text('Data Type')),
                                    flex: 1,
                                    fit: FlexFit.tight
                                  ),
                                  Flexible(
                                      child: Center(child: Text('Log Type')),
                                      flex: 1,
                                      fit: FlexFit.tight
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: dataType,
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  dataType = newValue;
                                                });
                                              },
                                              items: <String>['Objective', 'Pit'].map<DropdownMenuItem<String>>((String value) {
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
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: logType,
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  logType = newValue;
                                                });
                                              },
                                              items: <String>['Error', 'Complete'].map<DropdownMenuItem<String>>((String value) {
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
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                      children: <Widget>[
                                        Flexible(
                                            child: Padding(
                                                padding: EdgeInsets.only(left: 8.0, right: 4.0),
                                                child: RaisedButton(
                                                    child: Text('Load Data'),
                                                    color: Color(0xFF97D700),
                                                    textColor: Color(0xFF51284F),
                                                    onPressed: load
                                                )
                                            ),
                                            flex: 1,
                                            fit: FlexFit.tight
                                        ),
                                        Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 4.0, right: 8.0),
                                              child: RaisedButton(
                                                  child: Text('Accept Connections'),
                                                  color: Color(0xFF97D700),
                                                  textColor: Color(0xFF51284F),
                                                  onPressed: acceptDialog
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
                                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                                              child: TextField(
                                                controller: dataController,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    data = newValue;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                ),
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
                                                    child: Text('Upload Data'),
                                                    color: Color(0xFF97D700),
                                                    textColor: Color(0xFF51284F),
                                                    onPressed: upload
                                                )
                                            ),
                                            flex: 1,
                                            fit: FlexFit.tight
                                        ),
                                        Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 4.0, right: 8.0),
                                              child: RaisedButton(
                                                child: Text('Send Data'),
                                                color: Color(0xFF97D700),
                                                textColor: Color(0xFF51284F),
                                                onPressed: sendDialog,
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
    } else {
      return Scaffold(
          backgroundColor: Colors.transparent,
          key: scaffold,
          body: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0.0, top: 12.0), child: Center(child: Text('Send', style: TextStyle(fontSize: 22)))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListView(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Flexible(
                                      child: Center(child: Text('Data Type')),
                                      flex: 1,
                                      fit: FlexFit.tight
                                  ),
                                  Flexible(
                                      child: Center(child: Text('Log Type')),
                                      flex: 1,
                                      fit: FlexFit.tight
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: dataType,
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  dataType = newValue;
                                                });
                                              },
                                              items: <String>['Objective', 'Pit'].map<DropdownMenuItem<String>>((String value) {
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
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: logType,
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  logType = newValue;
                                                });
                                              },
                                              items: <String>['Error', 'Complete'].map<DropdownMenuItem<String>>((String value) {
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
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                      children: <Widget>[
                                        Padding(
                                                padding: EdgeInsets.only(left: 8.0, right: 4.0),
                                                child: RaisedButton(
                                                    child: Text('Load Data'),
                                                    color: Color(0xFF97D700),
                                                    textColor: Color(0xFF51284F),
                                                    onPressed: load
                                                )
                                        ),
                                      ]
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                      children: <Widget>[
                                        Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                                              child: TextField(
                                                controller: dataController,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    data = newValue;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
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
                                        Padding(
                                                padding: EdgeInsets.only(left: 8.0, right: 4.0),
                                                child: RaisedButton(
                                                    child: Text('Upload Data'),
                                                    color: Color(0xFF97D700),
                                                    textColor: Color(0xFF51284F),
                                                    onPressed: upload
                                                )
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
}