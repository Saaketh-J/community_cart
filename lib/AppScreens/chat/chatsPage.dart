import 'package:community_cart/AppScreens/chat/messagePage.dart';
import 'package:community_cart/firebaseObjects/userMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: Scaffold(
        // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          title: Text('Chat'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                var usersRef =
                    FirebaseDatabase.instance.reference().child("users");
                var conversationsRef = FirebaseDatabase.instance
                    .reference()
                    .child("conversations");
                await FirebaseAuth.instance.currentUser().then((currentUser) {
                  usersRef.once().then((DataSnapshot snapshot) {
                    Map<dynamic, dynamic> values = snapshot.value;
                    values.forEach((key, value) {
                      if (currentUser.uid != value['id']) {
                        print(value['name']);
                        conversationsRef
                            .child(currentUser.uid + "-" + value['id'])
                            .set(UserMessage(
                                "1012", 'text', null, 'system', 'message'));
                      }
                    });
                  });
                });
              },
            )
          ],
        ),
        body: MessageList(),
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  static final String time =
      DateTime.now().hour.toString() + ':' + DateTime.now().minute.toString();
  var messageList = [
    ListItemMessageTile(
        'Andrew Appleseed', 'Hey, doing groceries this week?', time),
    ListItemMessageTile('Benny Blair', ' how are you', time),
    ListItemMessageTile(
        'Claire Carthy', 'Hey dude howsdfjsjfksfjksajfsdf are you', time),
    ListItemMessageTile('Deena Daniel', 'Hey dude how are you', time),
    ListItemMessageTile('Eileen Enic', ' how are you', time),
    ListItemMessageTile(
        'Felix Fall', 'Hey dude howsdfjsjfksfjksajfsdf are you', time),
  ];

  Widget _buildRow(BuildContext context, ListItemMessageTile item) {
    return GestureDetector(
        onTap: () {
          print("YESS");
          // Navigator.pushNamed(context, '/message');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MessagePage(
                        chatName: item._name,
                      )));
          // Navigator.pushNamed(context, '/message');
        },
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          title: Text(
            item.getName,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Icon(Icons.check, color: Colors.lightBlue),
              Padding(
                padding: EdgeInsets.only(right: 10),
              ),
              Text(item.getMessage, style: TextStyle(color: Colors.black)),
            ],
          ),
          trailing: Text(
            item.getTime,
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messageList.length * 2,
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd)
          return Divider(
            color: Colors.grey,
            indent: 10,
            endIndent: 10,
          );

        return _buildRow(context, messageList[i ~/ 2]);
      },
    );
  }
}

class ListItemMessageTile {
  String _name, _message, _time;
  String get getName => _name;
  String get getMessage => _message;
  String get getTime => _time;
  ListItemMessageTile(this._name, this._message, this._time);
}
