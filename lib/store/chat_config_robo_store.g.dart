// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_config_robo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatConfigRoboStore on ChatConfigRoboStoreBase, Store {
  Computed<ObservableList<Message>> _$reversedMessagesComputed;

  @override
  ObservableList<Message> get reversedMessages =>
      (_$reversedMessagesComputed ??= Computed<ObservableList<Message>>(
              () => super.reversedMessages,
              name: 'ChatConfigRoboStoreBase.reversedMessages'))
          .value;

  final _$intentAtom = Atom(name: 'ChatConfigRoboStoreBase.intent');

  @override
  ConfigRoboIntent get intent {
    _$intentAtom.reportRead();
    return super.intent;
  }

  @override
  set intent(ConfigRoboIntent value) {
    _$intentAtom.reportWrite(value, super.intent, () {
      super.intent = value;
    });
  }

  final _$messagesAtom = Atom(name: 'ChatConfigRoboStoreBase.messages');

  @override
  ObservableList<Message> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(ObservableList<Message> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  final _$loadingMessagesAtom =
      Atom(name: 'ChatConfigRoboStoreBase.loadingMessages');

  @override
  ObservableList<Message> get loadingMessages {
    _$loadingMessagesAtom.reportRead();
    return super.loadingMessages;
  }

  @override
  set loadingMessages(ObservableList<Message> value) {
    _$loadingMessagesAtom.reportWrite(value, super.loadingMessages, () {
      super.loadingMessages = value;
    });
  }

  final _$acoesRoboAtom = Atom(name: 'ChatConfigRoboStoreBase.acoesRobo');

  @override
  ObservableList<AcaoRobo> get acoesRobo {
    _$acoesRoboAtom.reportRead();
    return super.acoesRobo;
  }

  @override
  set acoesRobo(ObservableList<AcaoRobo> value) {
    _$acoesRoboAtom.reportWrite(value, super.acoesRobo, () {
      super.acoesRobo = value;
    });
  }

  final _$addMessageAsyncAction =
      AsyncAction('ChatConfigRoboStoreBase.addMessage');

  @override
  Future<bool> addMessage({String msg, String owner, bool writing}) {
    return _$addMessageAsyncAction
        .run(() => super.addMessage(msg: msg, owner: owner, writing: writing));
  }

  final _$carregarAcoesRoboStoreAsyncAction =
      AsyncAction('ChatConfigRoboStoreBase.carregarAcoesRoboStore');

  @override
  Future carregarAcoesRoboStore() {
    return _$carregarAcoesRoboStoreAsyncAction
        .run(() => super.carregarAcoesRoboStore());
  }

  final _$ChatConfigRoboStoreBaseActionController =
      ActionController(name: 'ChatConfigRoboStoreBase');

  @override
  dynamic setIntent(ConfigRoboIntent intent) {
    final _$actionInfo = _$ChatConfigRoboStoreBaseActionController.startAction(
        name: 'ChatConfigRoboStoreBase.setIntent');
    try {
      return super.setIntent(intent);
    } finally {
      _$ChatConfigRoboStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
intent: ${intent},
messages: ${messages},
loadingMessages: ${loadingMessages},
acoesRobo: ${acoesRobo},
reversedMessages: ${reversedMessages}
    ''';
  }
}
