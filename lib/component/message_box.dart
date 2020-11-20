import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  @override
  _MessageBoxState createState() => _MessageBoxState();

  final int index;
  final String msg;
  final String owner;
  final bool writing;

  const MessageBox({Key key, this.index, this.msg, this.owner, this.writing})
      : super(key: key);
}

class _MessageBoxState extends State<MessageBox> {
  Widget avatar({String owner}) {
    return owner == 'bot'
        ? Image(
            image: AssetImage('assets/small/robot64.png'),
          )
        : SizedBox(height: 20);
  }

  Container message({BuildContext context, String msg, String owner}) {
    return Container(
      alignment: owner == 'user' ? Alignment.bottomRight : Alignment.bottomLeft,
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          avatar(owner: owner),
          ConstrainedBox(
            constraints: new BoxConstraints(
              maxHeight: 300.0,
              maxWidth: MediaQuery.of(context).size.width * 0.70,
              minHeight: 60.0,
              minWidth: 30.0,
            ),
            child: Container(
            //height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.70,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(21),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
              child: Text(
                msg,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }

  Container messageLoading({BuildContext context, String owner}) {
    return Container(
      alignment: owner == 'user' ? Alignment.bottomRight : Alignment.bottomLeft,
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          avatar(owner: owner),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.70,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(21),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(222, 30, 0, 0),
              child: Image.asset(
                "assets/original/loading-message.gif",
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.writing
        ? messageLoading(context: context, owner: widget.owner)
        : message(context: context, msg: widget.msg, owner: widget.owner);
  }
}
