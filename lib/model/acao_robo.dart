import 'package:chap_flutter/model/robo.dart';

class AcaoRobo {

  int id;
  Robo robo;
  String nome;
  String descricao;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  AcaoRobo({
    this.id,
    this.robo,
    this.nome,
    this.descricao,
    this.createdAt,
    this.updatedAt,
    this.deletedAt
  });
}