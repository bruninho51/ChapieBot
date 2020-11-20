import 'package:chap_flutter/config/chatbot_config_robo_config.dart';
import 'package:chap_flutter/intent/config_robo_intent.dart';
import 'package:chap_flutter/model/acao_robo.dart';
import 'package:chap_flutter/model/message.dart';
import 'package:chap_flutter/model/robo.dart';
import 'package:chap_flutter/repository/acao_robo_repository.dart';
import "package:mobx/mobx.dart";
part "chat_config_robo_store.g.dart";

class ChatConfigRoboStore = ChatConfigRoboStoreBase with _$ChatConfigRoboStore;

abstract class ChatConfigRoboStoreBase with Store {

  ChatConfigRoboStoreBase({robo}) {
    setRobo(robo);
    init();
  }

  init() {
    carregarAcoesRoboStore();
    executarIntentEscolherConfig();
  }

  executarIntentEscolherConfig() async {
    await addMessage(
      msg: "Olá! Eu sou O ${robo.nome} que você deseja fazer?",
      owner: 'bot'
    );
    setIntent(ConfigRoboIntent.ESCOLHER_CONFIG);
  }

  executarIntentCriarAcao() async {
    await addMessage(
      msg: 'Por favor, me informe o nome da ação que você deseja criar',
      owner: 'bot'
    );
    setIntent(ConfigRoboIntent.CRIAR_ACAO);
  }

  criarAcaoRobo(String nomeAcao) async {

    AcaoRobo acao = new AcaoRobo(
      robo: this.robo,
      nome: nomeAcao, 
      descricao: nomeAcao,
    );

    AcaoRoboRepository.save(acao)
      .then((_) {
        addMessage(
          msg: "Ação criada - $nomeAcao",
          owner: 'bot'
        );
        init();
      })
      .catchError((onError) {
        addMessage(
          msg: 'Desculpe, não consegui salvar a ação', 
          owner: 'bot'
        );
      });
  }

  executarIntentExecutarAcao() async {
    if (this.acoesRobo.length == 0) {
      await addMessage(
        msg: 'Nenhuma ação foi cadastrada. Não há ações para serem executadas!',
        owner: 'bot'
      );
      init();
      return;
    }

    await addMessage(
      msg: 'Escolha a ação que você deseja executar',
      owner: 'bot'
    );
    setIntent(ConfigRoboIntent.EXECUTAR_ACAO);
    
  }

  @observable
  Robo robo;

  @observable
  ConfigRoboIntent intent;

  @observable
  ObservableList<Message> messages = <Message>[].asObservable();

  @observable
  ObservableList<Message> loadingMessages =
      <Message>[].asObservable();

  @computed
  ObservableList<Message> get reversedMessages {
    ObservableList<Message> all = <Message>[].asObservable();
    all.addAll(this.messages);
    all.addAll(this.loadingMessages);
    return all.reversed.toList().asObservable();
  }

  @observable
  ObservableList<AcaoRobo> acoesRobo = <AcaoRobo>[].asObservable();

  @action
  setIntent(ConfigRoboIntent intent) {
    this.intent = intent;
  }

  @action
  setRobo(Robo robo) {
    this.robo = robo;
  }

  @action
  Future<bool> addMessage({String msg, String owner, bool writing}) async {
    /**
     * Regra Padrâo:
     * Se writing não for passado, 
     * mensagens do bot exibirão writing e mensagens do usuário não exibirão writing
     */
    bool loading = writing;
    if (writing == null) {
      loading = owner == 'bot';
    }

    Message message =
        new Message(msg: msg, owner: owner, writing: loading);

    if (loading) {
      this.loadingMessages.add(message);
      return Future.delayed(
        const Duration(seconds: ChatbotConfigRoboConfig.WRITING_TIME_SECOND),
        () {
          this.loadingMessages.removeWhere(
              (loadingMessage) => loadingMessage.uuid == message.uuid);
          message.writing = false;
          this.messages.add(message);
          return true;
        },
      );
    } else {
      this.messages.add(message);
      return Future.value(true);
    }
  }

  @action
  carregarAcoesRoboStore() async {
    this.acoesRobo = (await AcaoRoboRepository.getAll()).asObservable();
  }

}