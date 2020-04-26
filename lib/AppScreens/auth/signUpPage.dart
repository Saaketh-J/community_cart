import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController nameController = TextEditingController(text: "Danny");
  TextEditingController emailController =
      TextEditingController(text: "Danny@gmail.com");
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
              Text("Create Account"),
              Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              TextField(
                  controller: nameController,
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
                  hintText: 'Enter Email',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xffED820E), width: 0.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
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
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xffED820E), width: 0.0),
                    ),
                  )),
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
                onPressed: () async {
                  var email = emailController.text;
                  var password = passwordController.text;

                  final FirebaseUser newUser =
                      (await _auth.createUserWithEmailAndPassword(
                              email: email, password: password))
                          .user;

                  var uid = newUser.uid;
                  var userObject = {
                    'id': uid,
                    'name': nameController.text,
                    'email': email,
                    'password': password,
                    'phone': phoneController.text,
                    'address': addressController.text
                  };
                  var newUserRef = FirebaseDatabase.instance
                      .reference()
                      .child("users")
                      .child(uid);
                  newUserRef.set(userObject);
                  Navigator.pushNamed(context, '/home');
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          margin: const EdgeInsets.all(40),
        ));
  }
}
