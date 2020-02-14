import 'package:flutter_for_web/material.dart';

import 'instructions.dart';
import 'objective.dart';
import 'pit.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String team = '';
  int currentIndex = 0;
  void initState() {
    super.initState();
  }
  final List<Widget> children = [
    Instructions(),
    Objective(),
    Pit()
  ];
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: children[currentIndex],
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
            child: BottomNavigationBar(

              onTap: onTabTapped,
              currentIndex: currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: IconTheme(
                      data: IconThemeData(color: Color(0xFF97D700)),
                      child: Icon(Icons.playlist_add_check),
                    ),
                    title: Text(
                      'Instructions',
                      style: TextStyle(color: Color(0xFF97D700)),
                    )
                ),
                BottomNavigationBarItem(
                    icon: IconTheme(
                      data: IconThemeData(color: Color(0xFF97D700)),
                      child: Icon(Icons.web),
                    ),
                    title: Text(
                      'Objective',
                      style: TextStyle(color: Color(0xFF97D700)),
                    )
                ),
                BottomNavigationBarItem(
                    icon: IconTheme(
                      data: IconThemeData(color: Color(0xFF97D700)),
                      child: Icon(Icons.dashboard),
                    ),
                    title: Text(
                      'Pit',
                      style: TextStyle(color: Color(0xFF97D700)),
                    )
                ),
              ],
            ),
          )
    );
  }
}