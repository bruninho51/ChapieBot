import 'acao_robo.dart';

class ExecucaoAcaoRobo {

  int id;
  AcaoRobo acao;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  ExecucaoAcaoRobo({
    this.id,
    this.acao,
    this.createdAt,
    this.updatedAt,
    this.deletedAt
  });
}