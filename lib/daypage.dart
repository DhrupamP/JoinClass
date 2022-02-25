import 'dart:convert';
import 'Components/cell.dart';
import 'constants.dart' as constants;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final database = FirebaseDatabase.instance.ref();
late DatabaseReference? dayrefer;
String url = "https://joinclass-82ed3-default-rtdb.firebaseio.com/$uid.json";
late var ans;

bool isEmpty = true;
String uid = "P3RGCPnA5ldTszcxHhwvUgSCTAt1";

class DayPage extends StatefulWidget {
  const DayPage({Key? key, required this.day}) : super(key: key);
  final String day;
  @override
  _DayPageState createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  @override
  void getData(String da) {
    final dayref = database.child("/" + constants.uid + "/" + da);
    dayrefer = dayref;
    dayref.onValue.listen((event) async {
      setState(() {
        ans = event.snapshot.value;
        if (ans != null) {
          isEmpty = false;
        }
      });
    });
  }

  Widget build(BuildContext context) {
    getData(widget.day);
    return isEmpty
        ? Container(
            child: Center(
              child: Text("kjdvkj"),
            ),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {},
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 60),
              child: FutureBuilder(builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: ans.length - 1,
                    itemBuilder: (_, int idx) {
                      return Cell(
                        sub: ans[idx + 1][0].toString(),
                        per: idx + 1,
                        time: ans[idx + 1][1].toString(),
                        day: widget.day,
                        link: ans[idx + 1][2],
                      );
                    });
              }),
            ),
          );
  }
}
