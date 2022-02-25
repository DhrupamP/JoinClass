import 'package:flutter/material.dart';

import '../auth/register.dart';
import 'package:joinclass/constants.dart' as constants;

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
    TextEditingController _subcontroller = TextEditingController();
    TextEditingController _timecontroller = TextEditingController();
    TextEditingController _linkcontroller = TextEditingController();

    final ref = database.child(constants.uid + "/" + widget.day);
    return AlertDialog(
        content: Container(
      height: 200,
      child: Column(
        children: [
          TextField(
            controller: _subcontroller,
            decoration: InputDecoration(hintText: "Subject name"),
          ),
          TextField(
            controller: _timecontroller,
            decoration: InputDecoration(hintText: "Time"),
          ),
          TextField(
            controller: _linkcontroller,
            decoration: InputDecoration(hintText: "link"),
          ),
          ElevatedButton(
              onPressed: () {
                ref.child("/" + widget.period.toString()).set({
                  "0": _subcontroller.text,
                  "1": _timecontroller.text,
                  "2": _linkcontroller.text
                });
                Navigator.pop(context);
              },
              child: Text("Edit"))
        ],
      ),
    ));
  }
}
