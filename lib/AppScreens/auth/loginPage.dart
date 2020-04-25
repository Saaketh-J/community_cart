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
          TextField(
            controller: emailController,
            decoration:
                InputDecoration(labelText: "Email", alignLabelWithHint: true),
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
