import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.grey[100],
          child: SpinKitChasingDots(
            color: Color(0xff005D76),
            size: 50.0,
          )),
    );
  }
}
