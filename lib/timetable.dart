import 'package:flutter/material.dart';
import 'daypage.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({Key? key}) : super(key: key);
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: DaysBar(),
      ),
    );
  }
}

List<Widget> days = [
  DayPage(day: "Monday"),
  DayPage(
    day: "Tuesday",
  ),
  DayPage(
    day: "Wednesday",
  ),
  DayPage(day: "Thursday"),
  DayPage(day: "Friday"),
  DayPage(day: "Saturday"),
];

int selectedindex = 0;

class DaysBar extends StatefulWidget {
  const DaysBar({Key? key}) : super(key: key);

  @override
  State<DaysBar> createState() => _DaysBarState();
}

class _DaysBarState extends State<DaysBar> {
  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        selectedindex = index;
      });
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Align(
            alignment: Alignment(0, -0.5),
            child: days[selectedindex],
          ),
          Align(
            alignment: Alignment(0, -1),
            child: Container(
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.update),
                    label: "M",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.update),
                    label: "T",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.update),
                    label: "W",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.update),
                    label: "T",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.update),
                    label: "F",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.update),
                    label: "S",
                  ),
                ],
                selectedFontSize: 20,
                selectedIconTheme: IconThemeData(opacity: 0.0, size: 0),
                unselectedIconTheme: IconThemeData(opacity: 0.0, size: 0),
                currentIndex: selectedindex,
                onTap: onItemTapped,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
