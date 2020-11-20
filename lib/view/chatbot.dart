import 'dart:async';
import 'package:chap_flutter/component/message_box.dart';
import 'package:chap_flutter/config/chatbot_config_robo_config.dart';
import 'package:chap_flutter/intent/config_robo_intent.dart';
import 'package:chap_flutter/model/execucao_acao_robo.dart';
import 'package:chap_flutter/repository/execucao_acao_robo_repository.dart';
import 'package:chap_flutter/store/chat_config_robo_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final ChatConfigRoboStore store = new ChatConfigRoboStore();

  var listScrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.77,
            child: Expanded(
              child: Observer(
                builder: (context) => ListView.builder(
                  itemCount: store.reversedMessages.length,
                  controller: listScrollController,
                  reverse: true,
                  itemBuilder: (_, index) => MessageBox(
                    index: index,
                    msg: store.reversedMessages[index].msg,
                    owner: store.reversedMessages[index].owner,
                    writing: store.reversedMessages[index].writing,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Observer(
                  builder: (context) {
                    switch (store.intent) {
                      case ConfigRoboIntent.ESCOLHER_CONFIG:
                        return seletorConfiguracao();
                      case ConfigRoboIntent.CRIAR_ACAO:
                        return entradaNomeAcao();
                      case ConfigRoboIntent.EXECUTAR_ACAO:
                        return seletorAcaoParaExecucao();
                      default:
                        return SizedBox(height: 16);
                    }
                  },
                ),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.112,
          ),
        ],
      ),
    );
  }

  Widget seletorConfiguracao() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        optionButton(
          text: 'Criar Ação',
          onPressed: () async {
            await store.addMessage(msg: 'Quero criar uma ação', owner: 'user');
            store.executarIntentCriarAcao();
          },
        ),
        optionButton(
          text: 'Executar Ação',
          onPressed: () async {
            await store.addMessage(msg: 'Quero executar uma ação ', owner: 'user');
            store.executarIntentExecutarAcao();
          },
        ),
      ],
    );
  }

  Widget entradaNomeAcao() {
    return TextField(
      decoration: InputDecoration(
        icon: new IconTheme(
          data: new IconThemeData(
            color: Colors.white), 
            child: new Icon(Icons.send),
        ),
        hintText: 'Digite o nome da ação',
        counterText: '',
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget seletorAcaoParaExecucao() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: store.acoesRobo.length,
      itemBuilder: (context, index) => optionButton(
        text: store.acoesRobo[index].nome,
        onPressed: () async {
          await ExecucaoAcaoRoboRepository.save(new ExecucaoAcaoRobo(
            acao: store.acoesRobo[index]
          ));
          store.addMessage(msg: store.acoesRobo[index].nome, owner: 'user').then(
            (bool messageWrited) {
              Timer(
                Duration(seconds: ChatbotConfigRoboConfig.CHATBOT_READING_TIME_SECOND),
                () async => store.executarIntentEscolherConfig(),
              );
            },
          );
        },
      ),
    );
  }

  Widget seletorSairDoChat(BuildContext context) {
    return optionButton(
      text: 'Voltar para tela de opções',
      onPressed: () async {
        Navigator.pushReplacementNamed(context, '/options');
      },
    );
  }

  Widget optionButton({String text, Function onPressed}) {
    return Container(
        margin: EdgeInsets.only(right: 8, top: 2, bottom: 2),
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.red)),
            color: Colors.white,
            textColor: Colors.red,
            padding: EdgeInsets.all(8.0),
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
    ); 
    
  }
}
