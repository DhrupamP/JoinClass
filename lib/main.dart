import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joinclass/constants.dart';
import 'timetable.dart';
import 'auth/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'DmSans'),
    debugShowCheckedModeBanner: false,
    home: Register(),
  ));
}
