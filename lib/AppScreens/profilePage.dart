import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:community_cart/globals.dart' as globals;

class ProfilePage extends StatelessWidget {
    static var email = globals.userName;
    static var name = '';
    static var password = '';
    static var phone = '';
    static var address = '';

  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController phoneController;
  TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    var usersRef = FirebaseDatabase.instance.reference().child("users");
    usersRef.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        if (email == value['email']) {
          name = value['name'];
          password = value['password'];
          phone = value['phone'];
          address = value['address'];
        }
      });
    });

    nameController = TextEditingController(text: name);
    emailController = TextEditingController(text: email);
    passwordController = TextEditingController(text: password);
    phoneController = TextEditingController(text: phone);
    addressController = TextEditingController(text: address);

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        /*body: Column(
          children:[
            Text('Name: ' + name),
            Text('Email: ' + email),
            Text('Password: ' + password),
            Text('Phone: ' + phone),
            Text('Address: ' + address),
          ],
        )*/

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
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          margin: const EdgeInsets.all(50),
        ),
    );
  }
}
