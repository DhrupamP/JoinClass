import 'package:flutter/material.dart';
import 'daypage.dart';
import 'constants.dart';
import 'auth/register.dart';
import 'auth/login.dart';

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
    void logOut() {
      auth.signOut().then(
            (value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Login();
                },
              ),
            ),
          );
    }

    changeData() async {
      dynamic ans = await getData(weekDays[selectedindex]);
      //print(ans);
      if (ans != "" && ans != null) {
        setState(() {
          res = ans;
        });
      } else
        setState(() {
          res = [];
        });
    }

    void onItemTapped(int index) async {
      setState(() {
        selectedindex = index;
      });
      changeData();
    }

    changeData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Time Table',
            style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.blueGrey,
              ),
              onPressed: () {
                logOut();
              },
            ),
          ],
          backgroundColor: Color(0xffD3E2E7),
        ),
        body: Stack(children: [
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
        //row method
        // body: Stack(
        //   children: [
        //     Align(
        //       alignment: Alignment(0, -1),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           TextButton(
        //             onPressed: () {},
        //             child: Text("M"),
        //           ),
        //           TextButton(
        //             onPressed: () {},
        //             child: Text("T"),
        //           ),
        //           TextButton(
        //             onPressed: () {},
        //             child: Text("W"),
        //           ),
        //           TextButton(
        //             onPressed: () {},
        //             child: Text("T"),
        //           ),
        //           TextButton(
        //             onPressed: () {},
        //             child: Text("F"),
        //           ),
        //           TextButton(
        //             onPressed: () {},
        //             child: Text("S"),
        //           ),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
