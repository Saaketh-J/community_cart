import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:community_cart/globals.dart' as globals;

class LoginPage extends StatelessWidget {
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
                    labelText: "Email", alignLabelWithHint: true),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password", alignLabelWithHint: true),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              RaisedButton(
                  child: Text("Log In"),
                  onPressed: () {
                    var email = emailController.text;
                    var password = passwordController.text;

                    var usersRef =
                        FirebaseDatabase.instance.reference().child("users");
                    usersRef.once().then((DataSnapshot snapshot) {
                      Map<dynamic, dynamic> values = snapshot.value;
                      values.forEach((key, value) {
                        if (email == value['email'] &&
                            password == value['password']) {
                          globals.userName = email;
                          Navigator.pushNamed(context, "/home");
                        }
                      });
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
        ));
  }
}
