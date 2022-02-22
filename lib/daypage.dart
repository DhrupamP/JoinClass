import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final database = FirebaseDatabase.instance.ref();
late DatabaseReference dayrefer;
var ans;

void getData(String da) async {
  final dayref = database.child("/uid/Friday/");
  dayrefer = dayref;
  dayref.onValue.listen((event) async {
    ans = await event.snapshot.value;
    print(";adsnfvlsdnV");

    print(ans[2][0]);
  });
}

class DayPage extends StatefulWidget {
  const DayPage({Key? key, required this.day}) : super(key: key);
  final String day;
  @override
  _DayPageState createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  @override
  void initState() {
    getData(widget.day);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            Column(
              children: [
                TimeCell(),
                TimeCell(),
                TimeCell(),
                TimeCell(),
              ],
            ),
            Column(
              children: [
                Cell(
                  sub: ans[1][0],
                  day: widget.day,
                  per: 1,
                ),
                // Cell(
                //   sub: ans[2].toString(),
                //   day: widget.day,
                //   per: 2,
                // ),
                // Cell(
                //   sub: ans[3].toString(),
                //   day: widget.day,
                //   per: 3,
                // ),
                // Cell(
                //   sub: ans[4].toString(),
                //   day: widget.day,
                //   per: 4,
                // )
              ],
            ),
            ElevatedButton(onPressed: addList, child: Text("akfgSDBDV"))
          ],
        ),
      ),
    );
  }
}

class Cell extends StatefulWidget {
  const Cell(
      {Key? key, required this.day, required this.per, required this.sub})
      : super(key: key);
  final String day;
  final int per;
  final String sub;
  @override
  _CellState createState() => _CellState();
}

class _CellState extends State<Cell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          children: [
            Text(
              "widget.",
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return EditAlert(
                                day: widget.day,
                                period: widget.per,
                              );
                            });
                      });
                    },
                    icon: Icon(Icons.edit))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TimeCell extends StatefulWidget {
  const TimeCell({Key? key}) : super(key: key);

  @override
  _TimeCellState createState() => _TimeCellState();
}

class _TimeCellState extends State<TimeCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.black),
      ),
    );
  }
}

class EditAlert extends StatefulWidget {
  const EditAlert({Key? key, required this.day, required this.period})
      : super(key: key);
  final String day;
  final int period;
  @override
  _EditAlertState createState() => _EditAlertState();
}

class _EditAlertState extends State<EditAlert> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _mycontroller = TextEditingController();
    String d = widget.day;

    final ref = database.child("/$d");
    return AlertDialog(
        content: Container(
      height: 200,
      child: Column(
        children: [
          TextField(
            controller: _mycontroller,
            decoration: InputDecoration(hintText: "Subject name"),
          ),
          ElevatedButton(
              onPressed: () {
                ref
                    .child("/" + widget.period.toString())
                    .set("/" + _mycontroller.text);
                Navigator.pop(context);
              },
              child: Text("Edit"))
        ],
      ),
    ));
  }
}

Map<String, Map<String, String>> dummy = {
  "Monday": {"": ""},
  "Tuesday": {},
  "Wednesday": {},
  "Thursday": {},
  "Friday": {},
  "Saturday": {},
};
List<String> period = ["sub", "time", "link"];
void addList() {
  final refer = database;
  refer.child("/uid").child("Friday/1").set(period);
}
