import 'package:firebase_database/firebase_database.dart';

final database = FirebaseDatabase.instance.ref();
String uid = "P3RGCPnA5ldTszcxHhwvUgSCTAt1";
const List<String> weekDays = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday'
];

Future getData(String da) async {
  DatabaseReference dayref = database.child("/" + uid + "/" + da);
  DatabaseEvent event = await dayref.once();
  return event.snapshot.value;
}

Future getsublink(String da, int p) async {
  DatabaseReference dayref =
      database.child("/" + uid + "/" + da + "/" + p.toString());
  DatabaseEvent event = await dayref.once();
  return event.snapshot.value;
}
