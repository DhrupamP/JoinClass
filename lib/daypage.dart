import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DayPage extends StatefulWidget {
  const DayPage({Key? key, required this.day}) : super(key: key);
  final String day;
  @override
  _DayPageState createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  final database = FirebaseDatabase.instance.ref();
  List ans = [];

  @override
  void initState() {
    super.initState();
  }

  void getData(String da) {
    final dayref = database.child("/$da");
    dayref.onValue.listen((event) {
      setState(() {
        ans = event.snapshot.value as List;
        // print(ans);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String d = widget.day;
    setState(() {
      getData(d);
    });
    return Container(
      child: SingleChildScrollView(
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
                  sub: ans[1].toString(),
                ),
                Cell(
                  sub: ans[2].toString(),
                ),
                Cell(
                  sub: ans[3].toString(),
                ),
                Cell(
                  sub: ans[4].toString(),
                )
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  database.child("/$d").child("1").set("hello");
                },
                child: Text("edit"))
          ],
        ),
      ),
    );
  }
}

class Cell extends StatefulWidget {
  const Cell({Key? key, required this.sub}) : super(key: key);
  final String sub;
  @override
  _CellState createState() => _CellState();
}

class _CellState extends State<Cell> {
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
        child: Center(child: Text(widget.sub)),
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
