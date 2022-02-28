import 'package:flutter/material.dart';
import 'edit_alert.dart';

class Cell extends StatefulWidget {
  const Cell(
      {Key? key,
      required this.time,
      required this.link,
      required this.per,
      required this.sub,
      required this.day})
      : super(key: key);
  final String day;
  final String time;
  final String link;
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
      padding: const EdgeInsets.all(20.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              color: Color(0xffD3E2E7),
              // border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  widget.time,
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                ),
                Spacer(),
                Text(
                  widget.sub,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return EditAlert(
                              day: widget.day,
                              period: widget.per,
                            );
                          });
                      setState(() {
                      });
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blueGrey,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
