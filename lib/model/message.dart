import 'package:uuid/uuid.dart';

class Message {
  String uuid = Uuid().v1();
  String msg;
  String owner;
  bool writing;

  Message(
      {this.msg, this.owner, this.writing});
}
