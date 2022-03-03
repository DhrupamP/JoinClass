import 'package:flutter/material.dart';
import 'package:joinclass/Components/loading.dart';
import 'package:joinclass/timetable.dart';
import '../auth/register.dart';
import 'package:joinclass/constants.dart' as constants;

int? shr = 0;
int? smin = 0;
int? ehr = 0;
int? emin = 0;

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
  bool _loading=false;
  getPeriod() async {
    setState(() {
      _loading=true;
    });
    dynamic ans = await constants.getsublink(widget.day, widget.period);
    setState(() {
      res = ans;
      _loading=false;
    });
  }

  @override
  void initState() {
    super.initState();
    getPeriod();
  }

  @override
  void dispose() {
    smin = shr = emin = ehr = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _subcontroller = TextEditingController();
    TextEditingController _linkcontroller = TextEditingController();
    final ref = database.child(constants.uid + "/" + widget.day);
    _subcontroller.text = res == null ? "" : res[0].toString();
    _linkcontroller.text = res == null ? "" : res[2].toString();
    return _loading ? Loading() : AlertDialog(
        content: Container(
      height: 260,
      child: Column(
        children: [
          TextField(
            controller: _subcontroller,
            decoration: InputDecoration(hintText: "Subject name"),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Text(shr.toString() + ":" + smin.toString()),
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
                  setState(() {
                    shr = result?.hour;
                    smin = result?.minute;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xff005D76),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
                child: Text("to"),
              ),
              ElevatedButton(
                child: Text(ehr.toString() + ":" + emin.toString()),
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
                  setState(() {
                    ehr = result?.hour;
                    emin = result?.minute;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xff005D76),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _linkcontroller,
            decoration: InputDecoration(hintText: "Link"),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _loading=true;
                  });
                  ref.child("/" + widget.period.toString()).set({
                    "0": _subcontroller.text,
                    "1": "$shr:$smin-$ehr:$emin",
                    "2": _linkcontroller.text
                  }).then((value) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    setState(() {
                      _loading=false;
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TimeTable();
                    }));
                  });
                  setState(() {
                    shr = smin = ehr = emin = 0;
                  });
                },
                child: Text("Edit"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xff005D76),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    ref.child(widget.period.toString()).remove();
                  });
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TimeTable();
                  }));
                },
                child: Text("Delete"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
              )
            ],
          )
        ],
      ),
    ));
  }
}
