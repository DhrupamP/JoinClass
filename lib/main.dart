import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:joinclass/timetable.dart';
import 'auth/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var uid_s = pref.getString('uid');
  uid = uid_s.toString();
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'DmSans',
    ),
    debugShowCheckedModeBanner: false,
    home: uid_s == null ? Register() : TimeTable(),
  ));
}
