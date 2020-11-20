import 'package:chap_flutter/model/execucao_acao_robo.dart';
import 'package:sqflite/sqlite_api.dart';
import '../database/conexao.dart';
import '../util/date_helper.dart';
import 'acao_robo_repository.dart';

class ExecucaoAcaoRoboRepository {

  static final Conexao _conexao = Conexao.instance;

  static final String table = 'execucao';

  static Future<int> save(ExecucaoAcaoRobo execucao) async {
      Database db = await _conexao.database;

      return await db.insert(table, {
        'id_acao': execucao.acao.id,
        'createdAt': DateHelper.currentTimeInSeconds()
      });
  }

  static Future<List<ExecucaoAcaoRobo>> getAll() async {
      Database db = await _conexao.database;

      List<Map<String, dynamic>> result = await db.query(table);

      List<ExecucaoAcaoRobo> execucoes = List<ExecucaoAcaoRobo>();

      if (result.length > 0) {
        result.forEach((roboMap) async => {
          execucoes.add(ExecucaoAcaoRobo(
            id: roboMap['id'],
            acao: await AcaoRoboRepository.getById(int.parse(roboMap['id_acao'])),
            createdAt: DateHelper.secondsToDateTime(roboMap['createdAt'] ?? 0),
            updatedAt: DateHelper.secondsToDateTime(roboMap['updatedAt'] ?? 0),
            deletedAt: DateHelper.secondsToDateTime(roboMap['deletedAt'] ?? 0)
          ))
        });
      }

      return Future.value(execucoes);
  }

  static Future<ExecucaoAcaoRobo> getById(int id) async {
    Database db = await _conexao.database;

    List<Map<String, dynamic>> result = await db.query(table, where: 'id = ?', whereArgs: [id]);

    if (result.length != 0) {
      Map<String, dynamic> roboMap = result.first;
      return Future.value(ExecucaoAcaoRobo(
        id: roboMap['id'],
        acao: await AcaoRoboRepository.getById(int.parse(roboMap['id_acao'])),
        createdAt: DateHelper.secondsToDateTime(roboMap['createdAt'] ?? 0),
        updatedAt: DateHelper.secondsToDateTime(roboMap['updatedAt'] ?? 0),
        deletedAt: DateHelper.secondsToDateTime(roboMap['deletedAt'] ?? 0)
      ));
    }

    return Future.value(null);
  }

}