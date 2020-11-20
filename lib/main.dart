import 'package:chap_flutter/view/cadastro_robo.dart';
import 'package:chap_flutter/view/first_page.dart';
import 'package:chap_flutter/view/lista_robo.dart';
import 'package:flutter/material.dart';
import 'package:chap_flutter/database/conexao.dart';

import 'view/chatbot.dart';

void main() {
  runApp(MyHomePage(title: 'People Cost'));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Conexao conexao = Conexao.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/cadastro_robo': (context) => CadastroRobo(),
        '/chatbot': (context) => Chatbot(),
        '/listagem_robo': (context) => ListaRobo(),
      },
    );
  }
}
