import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final database = FirebaseDatabase.instance.ref();

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passcontroller = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailcontroller,
          ),
          TextField(
            controller: passcontroller,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                auth
                    .createUserWithEmailAndPassword(
                        email: emailcontroller.text,
                        password: passcontroller.text)
                    .then((value) {
                  final ref = database.child(value.user!.uid);
                  ref.child("/123").set("dhrupam");
                });
              },
              child: Text("Signin"),
            ),
          ),
        ],
      ),
    );
  }
}
