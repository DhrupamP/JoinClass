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
              widget.sub,
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                    icon: Icon(Icons.edit))
              ],
            )
          ],
        ),
      ),
    );
  }
}
