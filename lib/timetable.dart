import 'package:flutter/material.dart';
import 'daypage.dart';
import 'constants.dart';

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

int selectedindex = 0;
List<Object?> res = [];

class DaysBar extends StatefulWidget {
  const DaysBar({Key? key}) : super(key: key);
  @override
  State<DaysBar> createState() => _DaysBarState();
}

class _DaysBarState extends State<DaysBar> {
  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) async {
      setState(() {
        selectedindex = index;
      });
      dynamic ans = await getData(weekDays[selectedindex]);
      if (ans != null) {
        setState(() {
          res = ans;
        });
      }
    }

    changeData() async {
      dynamic ans = await getData(weekDays[selectedindex]);
      setState(() {
        res = ans;
      });
    }

    changeData();
    return SafeArea(
      child: Stack(children: [
        Align(
            alignment: Alignment(0, -0.5),
            child: DayPage(day: weekDays[selectedindex], ans: res)),
        Align(
          alignment: Alignment(0, -1),
          child: Container(
            child: BottomNavigationBar(
              backgroundColor: Color(0xff005D76),
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
              selectedItemColor: Colors.white,
              unselectedItemColor: Color(0xffD3E2E7),
              selectedFontSize: 20,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              selectedIconTheme: IconThemeData(opacity: 0.0, size: 0),
              unselectedIconTheme: IconThemeData(opacity: 0.0, size: 0),
              currentIndex: selectedindex,
              onTap: onItemTapped,
            ),
          ),
        ),
      ]),
    );
  }
}
