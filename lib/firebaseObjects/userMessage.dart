import 'package:firebase_database/firebase_database.dart';

class UserMessage {
  String _id, _messageType, _time, _author, _content;
  String get getId => _id;
  String get geMessageType => _messageType;
  String get getTime => _time;
  String get getAuthor => _author;
  String get getContent => _content;

  UserMessage(
      this._id, this._messageType, this._time, this._author, this._content);

  UserMessage.map(dynamic objArray) {
    this._id = objArray['id'];
    this._messageType = objArray['message_type'];
    this._time = objArray['time'];
    this._author = objArray['user'];
    this._content = objArray['message'];
  }

  UserMessage.fromDataSnapshot(DataSnapshot snapshot) {
    this._id = snapshot.value['id'];
    this._messageType = snapshot.value['message_type'];
    this._time = snapshot.value['time'];
    this._author = snapshot.value['user'];
    this._content = snapshot.value['message'];
  }

  toJson() {
    return ({
      'id': _id,
      'message_type': _messageType,
      'time': _time,
      'user': _author,
      'message': _content,
    });
  }
}
