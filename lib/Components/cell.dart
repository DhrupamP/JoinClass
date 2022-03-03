import 'package:flutter/material.dart';
import 'edit_alert.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchURL(widget.link);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Color(0xffD3E2E7),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.time,
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                ),
                Text(
                  widget.sub,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold),
                ),
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
