import 'package:chap_flutter/model/cor_robo.dart';

class Robo {

  int id;
  String nome;
  CorRobo cor;
  String imagem;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  Robo({
    this.id,
    this.nome,
    this.cor,
    this.imagem,
    this.createdAt,
    this.updatedAt,
    this.deletedAt
  });
}