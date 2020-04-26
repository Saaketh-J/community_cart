import 'package:community_cart/AppScreens/groupInfo.dart';
import 'package:community_cart/AppScreens/profilePage.dart';
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
        '/profile': (context) => ProfilePage(),
        '/map': (context) => mainBase(),
        '/chat': (context) => GroupInfoPage(),
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
  int navBarIndex = 0;

  void selectPage(int index)
  {
    setState(() {
      if(index == 0)
      {
          Navigator.pushNamed(context, "/map");
      }
      else if (index == 2)
      {
        Navigator.pushNamed(context, "/profile");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: navBarIndex,
        onTap: (int index)
        {
          setState(() {
            navBarIndex = index;
            selectPage(index);
          });
        },
        items: [
          new BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("images/fb_icon.png"),
                size: 0,
              ),
              title: Text('Explore'),
          ),
          new BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/fb_icon.png"),
              size: 0,
            ),
            title: Text('Chat'),
          ),
          new BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/fb_icon.png"),
              size: 0,
            ),
            title: Text('Profile'),
          ),
        ],
      ),
    );
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
        return mainBase();
      });
}
