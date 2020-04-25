import 'package:community_cart/AppScreens/pickupSchedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'groupInfo.dart';
import 'groupMain.dart';

class GroupInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 153, 18, 1.0),
      appBar: AppBar(
          title: Text("Groups"),
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0)),
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 50.0),
        ),
        Container(
          child: Text('Group Name', style: TextStyle(color: Color.fromRGBO(240, 153, 18, 1.0), fontSize: 55,), textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0), borderRadius: BorderRadius.circular(10.0)),
        ),
        Container(
          padding: EdgeInsets.only(top: 100.0),
        ),
        textBoxes('Chat', GroupInfoPage(), context, 55.0),
        Container(
          padding: EdgeInsets.only(top: 30.0),
        ),
        textBoxes('Schedule', Schedule(), context, 55.0),
        Container(
          padding: EdgeInsets.only(top: 30.0),
        ),
        textBoxes('Grocery List', GroupInfoPage(), context, 50.0),
        Container(
          padding: EdgeInsets.only(top: 30.0),
        ),
        textBoxes('Past Pick Ups', GroupInfoPage(), context, 45.0),
      ]),
      bottomNavigationBar: Container(
        height: 65.0,
        child: BottomAppBar(
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.chat, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.group, color: Colors.white),
                onPressed: () {
                  nextPage(context, MainGroupPage());
                },
              ),
              IconButton(
                icon: Icon(Icons.account_box, color: Colors.white),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

void nextPage(BuildContext context, page) {
  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return page;
      });
}

Widget textBoxes(title, page, context, size) {
  return Container(
    child: FlatButton(
      child: Text(title,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: size,
            color: Colors.white,
          )),
      onPressed: () => nextPage(context, page),
    ),
    decoration: BoxDecoration(
      color: Color.fromRGBO(61, 89, 171, 1.0),
      borderRadius: BorderRadius.circular(15.0),
    ),
  );
}
