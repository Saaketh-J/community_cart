import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final dbRef = FirebaseDatabase.instance.reference().child("Ana");

  TextEditingController nameController = TextEditingController(text: "Ana");
  TextEditingController emailController =
  TextEditingController(text: "Ana@gmail.com");
  TextEditingController passwordController =
  TextEditingController(text: "password");
  TextEditingController phoneController = TextEditingController(text: '1234');
  TextEditingController addressController = TextEditingController(
      text: "1 Amphitheatre Parkway Mountain View, CA 94043");



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          child: Column(
            children: <Widget>[
              Text("Profile"),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    alignLabelWithHint: true, labelText: "Name"),
              ),
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "Email", alignLabelWithHint: true)),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password", alignLabelWithHint: true),
              ),
              TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Phone", alignLabelWithHint: true)),
              TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                      labelText: "Address", alignLabelWithHint: true)),
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
                  var email = emailController.text;

                  var user = {
                    'name': nameController.text,
                    'email': email,
                    'password': passwordController.text,
                    'phone': phoneController.text,
                    'address': addressController.text
                  };
                  var newUserRef = FirebaseDatabase.instance
                      .reference()
                      .child("users")
                      .push();
                  newUserRef.set(user);

                  Navigator.pushNamed(context, '/home');
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
