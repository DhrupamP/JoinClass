import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:joinclass/Components/loading.dart';
import 'package:joinclass/constants.dart';
import 'package:joinclass/timetable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final database = FirebaseDatabase.instance.ref();

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _loading=false;
  void _login() async {
    final UserCredential user = (await auth.signInWithEmailAndPassword(
      email: username,
      password: password,
    ));
    if (user.user != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('uid', user.user!.uid);
      uid = user.user!.uid;
      var map = {};
      weekDays.forEach((day) => map[day] = [
            ['init']
          ]);
      database.child('/' + uid).set(map);

      /* weekDays.forEach((day) {
        print('yes');
        database.child('/' + uid + '/' + day.toString() + '/0').set("init");
        database.child('/' + uid + '/' + day.toString() + '/1').set("init");
      });*/
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const TimeTable();
      }));
    }
  }

  String username = "";
  String password = " ";
  bool _obscureText1 = true;
  final _formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return _loading ? Loading() : Scaffold(
      // backgroundColor: Color(0xffD3E2E7),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Form(
              key: _formKey1,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Welcome OnBoard!',
                    style: TextStyle(
                        fontSize: 39,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This Field is Required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: Colors.red,
                        contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Enter Email Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          username = val;
                        });
                      }),
                  SizedBox(height: 20),
                  TextFormField(
                      validator: (value)=>validatePassword(value.toString()),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 4.0),
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Enter Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText1 = !_obscureText1;
                            });
                          },
                          child: Icon(
                            _obscureText1
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText: _obscureText1,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      }),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment(0, 0.8),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff005D76))),
                          child: Text(
                            "REGISTER",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            hideKeyboard(context);
                            if(_formKey1.currentState!.validate()) {
                              setState(() {
                                _loading=true;
                              });
                                auth
                                    .createUserWithEmailAndPassword(
                                  email: username,
                                  password: password,
                                )
                                    .then((value) {
                                  _login();
                                });
                            };
                          },
                        )),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.black87,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return Login();
                      }));
                    },
                    child: Text('Already have a account? LogIn'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
void _showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(
        message,
        style: TextStyle(fontSize: 15),
      ),
    ),
  );
}
String? validatePassword(String value){
  /*Pattern lower = r'^(?=.*?[a-z])';
  Pattern upper = r'^(?=.*?[A-Z])';
  Pattern number= r'^(?=.*?[0-9])';*/
  RegExp regex1 = new RegExp(r'^(?=.*?[a-z])');
  RegExp regex2 = new RegExp(r'^(?=.*?[A-Z])');
  RegExp regex3 = new RegExp(r'^(?=.*?[0-9])');
  if(value.isEmpty){
    return 'This Field is Required';
  }
  if(!regex1.hasMatch(value)){
    return 'Password must contain lowercase letters';
  }
  /*if(!regex2.hasMatch(value)){
    return 'Password must contain uppercase letters';
  }
  if(!regex3.hasMatch(value)){
    return 'Password must contain numbers';
  }*/
  if(value.length<6) {
    return 'Length must be greater than 6 characters';
  }
  return null;
}