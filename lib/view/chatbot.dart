import 'dart:async';
import 'package:chap_flutter/component/message_box.dart';
import 'package:chap_flutter/config/chatbot_config_robo_config.dart';
import 'package:chap_flutter/intent/config_robo_intent.dart';
import 'package:chap_flutter/model/execucao_acao_robo.dart';
import 'package:chap_flutter/model/robo.dart';
import 'package:chap_flutter/repository/execucao_acao_robo_repository.dart';
import 'package:chap_flutter/service/scrap.dart';
import 'package:chap_flutter/store/chat_config_robo_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Chatbot extends StatefulWidget {
  final Robo robo;

  Chatbot({this.robo});

  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  ChatConfigRoboStore store;

  final listScrollController = new ScrollController();
  final nomeAcaoController = TextEditingController();

  @override
  initState() {
    super.initState();
    this.store = new ChatConfigRoboStore(robo: widget.robo);
  }

  @override
  void dispose() {
    listScrollController.dispose();
    nomeAcaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.77,
            child: Column(children: [
              Expanded(
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
            ]),
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
            await store.addMessage(
                msg: 'Quero que você execute uma ação ', owner: 'user');
            store.executarIntentExecutarAcao();
          },
        ),
      ],
    );
  }

  Widget entradaNomeAcao() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: TextField(
          controller: nomeAcaoController,
          decoration: InputDecoration(
            hintText: 'Digite o nome da ação',
            counterText: '',
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.width * 0.2,
        padding: EdgeInsets.only(left: 10),
        child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.transparent),
            ),
            color: Colors.transparent,
            textColor: Colors.transparent,
            onPressed: () {
              store.criarAcaoRobo(nomeAcaoController.text);
            },
            child: IconTheme(
              data: IconThemeData(
                color: Colors.white,
                size: 32,
              ),
              child: Icon(Icons.send),
            )),
      )
    ]);
  }

  Widget seletorAcaoParaExecucao() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: store.acoesRobo.length,
      itemBuilder: (context, index) => optionButton(
        text: store.acoesRobo[index].nome,
        onPressed: () async {
          await ExecucaoAcaoRoboRepository.save(
              new ExecucaoAcaoRobo(acao: store.acoesRobo[index]));

          String frase = await Scrap.getFrase(store.acoesRobo[index].nome);

          store
              .addMessage(
            msg: frase,
            owner: 'user',
          )
              .then(
            (bool messageWrited) {
              Timer(
                Duration(
                    seconds:
                        ChatbotConfigRoboConfig.CHATBOT_READING_TIME_SECOND),
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
          side: BorderSide(color: Colors.red),
        ),
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
