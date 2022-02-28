import 'Components/cell.dart';
import 'constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:joinclass/Components/edit_alert.dart';

final database = FirebaseDatabase.instance.ref();

class DayPage extends StatefulWidget {
  const DayPage({Key? key, required this.day, required this.ans})
      : super(key: key);
  final String day;
  final Object? ans;
  @override
  _DayPageState createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  var res;
  @override
  Widget build(BuildContext context) {
    res = widget.ans;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff005D76),
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return EditAlert(
                  day: widget.day,
                  period: res.length == 0 ? 1 : res.length,
                );
              });
        },
      ),
      body: res.length == 0
          ? Container(
              child: Center(
              child: Text("Press + to add period"),
            ))
          : Padding(
              padding: EdgeInsets.only(top: 60),
              child: FutureBuilder(builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: res.length - 1,
                    itemBuilder: (_, int idx) {
                      return Cell(
                        sub: res[idx + 1][0].toString(),
                        per: idx + 1,
                        time: res[idx + 1][1].toString(),
                        day: widget.day,
                        link: res[idx + 1][2].toString(),
                      );
                    });
              }),
            ),
    );
  }
}
