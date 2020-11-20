import 'package:chap_flutter/model/robo.dart';
import 'package:flutter/material.dart';

class CardRobo extends StatelessWidget  {
  
  CardRobo({ this.onDismissed, this.robo, this.onTap });
  final onDismissed;
  final Robo robo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: <Widget>[
          card(),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.blue,
                onTap: () {
                  this.onTap();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card card() {
    return Card(
    child: Padding(
      padding: EdgeInsets.all(5.0),
      child: ListTile(
        leading: Icon(Icons.desktop_windows),
        title: Text(robo.nome),
      ),
    ),
  );
  }
}