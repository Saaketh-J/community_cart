import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Text("Email"),
          TextField(
            controller: emailController,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Text("Password"),
          TextField(
            controller: passwordController,
          ),
          RaisedButton(
              child: Text("Log in"),
              onPressed: () {
                var name = emailController.text;
                var pw = passwordController.text;

                // Firebase
                // FirebaseDatabase.instance
                //     .reference()
                //     .child("written")
                //     .set(true);

                Navigator.pushNamed(context, "/home");
              }),
          Padding(
            padding: EdgeInsets.all(40),
          ),
          Text("Don't have an account sign up here"),
          FlatButton(
            child: Text("Sign up"),
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
