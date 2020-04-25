import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Text("Create Account"),
          TextField(
            decoration:
                InputDecoration(alignLabelWithHint: true, labelText: "Name"),
          ),
          TextField(
              decoration: InputDecoration(
                  labelText: "Adress", alignLabelWithHint: true)),
          TextField(
              decoration: InputDecoration(
                  labelText: "Email", alignLabelWithHint: true)),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                labelText: "Password", alignLabelWithHint: true),
          ),
          TextField(
              decoration: InputDecoration(
                  labelText: "Phone", alignLabelWithHint: true)),
          Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            children: <Widget>[
              Text("Connnect Social Media"),
              Padding(
                padding: EdgeInsets.only(right: 60),
              ),
              Image(
                image: AssetImage('lib/images/fb_icon.png'),
                height: 32,
                width: 32,
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
              ),
              Image(
                image: AssetImage('lib/images/google_icon.png'),
                height: 32,
                width: 32,
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            children: <Widget>[
              Text("Attach ID"),
              Padding(
                padding: EdgeInsets.only(right: 50),
              ),
              Icon(Icons.attach_file)
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 50),
          ),
          RaisedButton(
            child: Text("Sign Up"),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      margin: const EdgeInsets.all(50),
    ));
  }
}
