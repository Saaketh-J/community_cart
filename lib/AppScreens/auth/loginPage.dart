import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:community_cart/globals.dart' as globals;

class LoginPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController =
      TextEditingController(text: 'Ana@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: 'password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xffED820E), width: 0.0),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xffED820E), width: 0.0),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              RaisedButton(
                  child: Text("Log In"),
                  onPressed: () {
                    var email = emailController.text;
                    var password = passwordController.text;

                    _auth
                        .signInWithEmailAndPassword(
                            email: email, password: password)
                        .then((onValue) {
                      Navigator.pushNamed(context, '/home');
                    });
                  }),
              Padding(
                padding: EdgeInsets.all(40),
              ),
              Text("Don't have an account sign up here"),
              FlatButton(
                child: Text("Sign Up"),
                onPressed: () {
                  Navigator.pushNamed(context, "/signup");
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          margin: const EdgeInsets.all(50),

        ),
    );
  }
}
