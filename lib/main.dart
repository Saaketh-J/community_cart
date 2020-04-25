import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:community_cart/AppScreens/auth/loginPage.dart';
import 'package:community_cart/AppScreens/auth/signUpPage.dart';

import 'AppScreens/mapView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
            child: Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 450, left: 85),
            color: Colors.blueAccent,
            //height: 50.0,
            child: RaisedButton(
              color: Colors.deepOrangeAccent,
              child: Text('Find Users',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 40,
                    color: Color(0xff000080),
                  )),
              elevation: 6.0,
              onPressed: () {
                nextPage(context);
                FirebaseDatabase().reference().child("written").set(true);
              },
            ))
      ],
    )));
  }
}

void nextPage(BuildContext context) {
  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return MapView();
      });
}
