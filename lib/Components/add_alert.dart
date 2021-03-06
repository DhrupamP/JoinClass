import 'package:flutter/material.dart';
import 'package:joinclass/Components/loading.dart';
import 'package:joinclass/timetable.dart';
import '../auth/register.dart';
import 'package:joinclass/constants.dart' as constants;
import 'loading.dart';

int? shr = 0;
int? smin = 0;
int? ehr = 0;
int? emin = 0;
String? subtxt = "";
String? linktxt = "";

class AddAlert extends StatefulWidget {
  const AddAlert({Key? key, required this.day, required this.period})
      : super(key: key);
  final String day;
  final int period;
  @override
  _AddAlertState createState() => _AddAlertState();
}

class _AddAlertState extends State<AddAlert> {
  @override
  void dispose() {
    smin = shr = emin = ehr = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _loading = false;
    TextEditingController _subcontroller = TextEditingController();
    TextEditingController _linkcontroller = TextEditingController();
    _subcontroller.text = subtxt.toString() == null ? "" : subtxt.toString();
    _linkcontroller.text = linktxt.toString() == null ? "" : linktxt.toString();

    final ref = database.child(constants.uid + "/" + widget.day);

    return _loading
        ? Loading()
        : AlertDialog(
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
                        subtxt = _subcontroller.text.toString();
                        linktxt = _linkcontroller.text.toString();

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
                        subtxt = _subcontroller.text;
                        linktxt = _linkcontroller.text;

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
                          _subcontroller.text = subtxt.toString();
                          _linkcontroller.text = linktxt.toString();
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_subcontroller.text == null ||
                            _subcontroller.text == "" ||
                            _linkcontroller.text == null ||
                            _linkcontroller.text == "" ||
                            shr == null ||
                            smin == null ||
                            (shr == 0 && smin == 0 && ehr == 0 && emin == 0) ||
                            ehr == null ||
                            emin == null) {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  backgroundColor: Colors.blueGrey,
                                  content: Container(
                                    height: 100,
                                    width: 70,
                                    child: Center(
                                      child: Text(
                                        "Please fill all the details!",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          ref.child("/" + widget.period.toString()).set({
                            "0": _subcontroller.text,
                            "1": "$shr:$smin-$ehr:$emin",
                            "2": _linkcontroller.text
                          }).then((value) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return TimeTable();
                            }));
                          });
                          setState(() {
                            shr = smin = ehr = emin = 0;
                            subtxt = "";
                            linktxt = "";
                            _subcontroller.clear();
                            _linkcontroller.clear();
                          });
                        }
                      },
                      child: Text("Add Event"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xff005D76),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ));
  }
}
