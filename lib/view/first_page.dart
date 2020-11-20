import 'package:chap_flutter/repository/robo_repository.dart';
import 'package:chap_flutter/view/cadastro_robo.dart';
import 'package:chap_flutter/view/chatbot.dart';
import 'package:chap_flutter/view/lista_robo.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RoboRepository.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.length > 0) {
            return ListaRobo();
          } else {
            return CadastroRobo();
          }
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          );
        }
      },
    );
  }
}