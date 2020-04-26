import 'package:community_cart/firebaseObjects/userMessage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';

final dbref = FirebaseDatabase.instance.reference().child('messages');
// final storeageRef = FirebaseStorage.instance.ref().child('message');
bool switchstate = false;
String contactName;
final rdm = Random();
ScrollController _messageAreaController = ScrollController();

// This is the screen that displays the list of messages
class MessagePage extends StatelessWidget {
  final String chatName;
  MessagePage({this.chatName});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          title: Text(chatName),
          centerTitle: true,
        ),
        body: ListOfMessagesAndInput(),
      ),
    );
  }
}

// contains 3 widgets (switch-for testing, list of messages, compose message area)
class _ListOfMessagesAndInputState extends State<ListOfMessagesAndInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
          value: switchstate,
          onChanged: (bool val) {
            setState(() {
              switchstate = switchstate ? false : true;
            });
          },
          activeColor: Colors.yellowAccent,
        ),
        Flexible(
          child: Container(
            child: MessagesArea(),
          ),
        ),
        Divider(
          color: Colors.white,
          height: 0,
        ),
        NewMessageInput(),
      ],
    );
  }
}

class ListOfMessagesAndInput extends StatefulWidget {
  _ListOfMessagesAndInputState createState() => _ListOfMessagesAndInputState();
}

class MessagesArea extends StatefulWidget {
  _MessagesAreaState createState() => _MessagesAreaState();
}

class _MessagesAreaState extends State<MessagesArea> {
  List<UserMessage> items;
  StreamSubscription<Event> _onMessageAddedSubscription;
  StreamSubscription<Event> _onMessageChangedubscription;

  @override
  void initState() {
    super.initState();

    items = List();
    _onMessageAddedSubscription = dbref.onChildAdded.listen(_onMessageAdded);
    _onMessageChangedubscription =
        dbref.onChildChanged.listen(_onMessageUpdated);
  }

  @override
  void dispose() {
    _onMessageAddedSubscription.cancel();
    _onMessageChangedubscription.cancel();
    super.dispose();
  }

  void _onMessageAdded(Event event) {
    setState(() {
      items.add(UserMessage.fromDataSnapshot(event.snapshot));
    });
  }

  void _onMessageUpdated(Event event) {
    var oldMessageValue =
        items.singleWhere((msg) => (msg.getId == event.snapshot.key));
    setState(() {
      items[items.indexOf(oldMessageValue)] =
          UserMessage.fromDataSnapshot(event.snapshot);
    });
  }

  Widget _renderMessage(UserMessage msg) {
    bool left = msg.getAuthor[0] != 'P';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: left ? 2 : 0,
            child: left
                ? CircleAvatar(child: Text(msg.getAuthor[0]))
                : Container(),
          ),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment:
                  left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Text(msg.getAuthor,
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .apply(color: Colors.white)),
                ),
                Container(
                  margin: left
                      ? EdgeInsets.only(top: 2.0, right: 25.0)
                      : EdgeInsets.only(top: 2.0, left: 25.0),
                  child: msg.geMessageType == 'text'
                      ? Text(
                          msg.getContent,
                          style: TextStyle(color: Colors.white),
                          textAlign: left ? TextAlign.start : TextAlign.end,
                        )
                      : Image.network(msg.getContent, height: 200),
                ),
              ],
            ),
          ),
          Expanded(
            flex: left ? 0 : 2,
            child: left
                ? Container()
                : CircleAvatar(child: Text(msg.getAuthor[0])),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _messageAreaController,
      itemCount: items.length,
      itemBuilder: (context, position) {
        return _renderMessage(items[position]);
      },
    );
  }
}

class NewMessageInput extends StatefulWidget {
  _NewMessageInputState createState() => _NewMessageInputState();
}

class _NewMessageInputState extends State<NewMessageInput> {
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
  }

  Widget _buildTextComposer() {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextField(
        controller: _textController,
        style: TextStyle(color: Colors.white, fontSize: 16),
        onSubmitted: _handleSubmitted,
        decoration: InputDecoration.collapsed(
            hintText: "Compose a message...",
            hintStyle: TextStyle(color: Colors.white70)),
      ),
    );
  }

  postMessageToDB(UserMessage msg) async {
    await dbref.child(contactName).child(msg.getId).set(msg.toJson());
    _messageAreaController
        .jumpTo(_messageAreaController.position.maxScrollExtent);
  }

  // Future saaveImageToDB() async {
  //   String fileName = Uuid().v1().toString();
  //   var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   final StorageReference storageReference =
  //       FirebaseStorage.instance.ref().child('/message/' + fileName + '.jpg');

  //   var name = switchstate ? 'Peter Pan' : 'Wendy Darling';
  //   var timeNow = DateTime.now();
  //   String time = DateFormat('jm').format(timeNow);

  //   await storageReference.putFile(tempImage).onComplete;

  //   String url = await storeageRef.child(fileName + '.jpg').getDownloadURL();

  //   UserMessage message = UserMessage(
  //       DateTime.now().microsecondsSinceEpoch.toString() +
  //           rdm.nextInt(999999).toString(),
  //       'image',
  //       time,
  //       name,
  //       url);

  //   postMessageToDB(message);
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: IconButton(
            onPressed: () {
              // saveImageToDB();
            },
            icon: Icon(
              Icons.image,
              color: Colors.white,
            ),
          ),
        ),
        Flexible(
          child: _buildTextComposer(),
        ),
        Container(
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {
              var timeNow = DateTime.now();
              String time = DateFormat('jm').format(timeNow);

              var name = switchstate ? 'Peter Pan' : 'Wendy Darling';

              String uuid = DateTime.now().millisecondsSinceEpoch.toString() +
                  rdm.nextInt(999999).toString();
              UserMessage newMessage = UserMessage(
                  uuid, 'text', time, name, _textController.text.trim());
              postMessageToDB(newMessage);
              _textController.clear();
            },
          ),
        ),
      ],
    );
  }
}
