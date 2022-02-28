import 'package:flutter/material.dart';
import 'package:joinclass/timetable.dart';

import '../auth/register.dart';
import 'package:joinclass/constants.dart' as constants;

int? shr;
int? smin;

int? ehr;
int? emin;

class EditAlert extends StatefulWidget {
  const EditAlert({Key? key, required this.day, required this.period})
      : super(key: key);
  final String day;
  final int period;
  @override
  _EditAlertState createState() => _EditAlertState();
}

class _EditAlertState extends State<EditAlert> {
  var res;
  getPeriod() async {
    dynamic ans = await constants.getsublink(widget.day, widget.period);
    setState(() {
      res = ans;
    });
  }

  @override
  void initState() {
    super.initState();
    getPeriod();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _subcontroller = TextEditingController();

    TextEditingController _linkcontroller = TextEditingController();

    final ref = database.child(constants.uid + "/" + widget.day);

    _subcontroller.text = res[0].toString();
    _linkcontroller.text = res[2].toString();
    return AlertDialog(
        content: Container(
      height: 200,
      child: Column(
        children: [
          TextField(
            controller: _subcontroller,
            decoration: InputDecoration(hintText: "Subject name"),
          ),
          Row(
            children: [
              ElevatedButton(
                child: Text("Edit start time"),
                onPressed: () async {
                  final TimeOfDay? result = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (context, child) {
                        return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: false),
                            child: child!);
                      });
                  shr = result?.hour;
                  smin = result?.minute;
                },
              ),
              ElevatedButton(
                child: Text("Edit end time"),
                onPressed: () async {
                  final TimeOfDay? result = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (context, child) {
                        return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: false),
                            child: child!);
                      });
                  ehr = result?.hour;
                  emin = result?.minute;
                },
              ),
            ],
          ),
          TextField(
            controller: _linkcontroller,
            decoration: InputDecoration(hintText: "link"),
          ),
          ElevatedButton(
              onPressed: () {
                ref.child("/" + widget.period.toString()).set({
                  "0": _subcontroller.text,
                  "1": "$shr:$smin-$ehr:$emin",
                  "2": _linkcontroller.text
                }).then((value) {
                  Navigator.pop(context);
                });
              },
              child: Text("Edit"))
        ],
      ),
    ));
  }
}
