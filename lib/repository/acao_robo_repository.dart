import 'package:chap_flutter/model/acao_robo.dart';
import 'package:chap_flutter/repository/robo_repository.dart';
import 'package:sqflite/sqlite_api.dart';
import '../database/conexao.dart';
import '../util/date_helper.dart';

class AcaoRoboRepository {

  static final Conexao _conexao = Conexao.instance;

  static final String table = 'acao';

  static Future<int> save(AcaoRobo acaoRobo) async {
      Database db = await _conexao.database;

      return await db.insert(table, {
        'id_robo': acaoRobo.robo.id,
        'nome': acaoRobo.nome,
        'descricao': acaoRobo.descricao,
        'createdAt': DateHelper.currentTimeInSeconds()
      });
  }

  static Future<int> update(AcaoRobo acaoRobo) async {
      Database db = await _conexao.database;

      return await db.update(table, {
        'id_robo': acaoRobo.robo.id,
        'nome': acaoRobo.nome,
        'descricao': acaoRobo.descricao,
        'updatedAt': DateHelper.currentTimeInSeconds()
      }, where: 'id = ?', whereArgs: [acaoRobo.id]);
  }

  static Future<List<AcaoRobo>> getAll() async {
      Database db = await _conexao.database;

      List<Map<String, dynamic>> result = await db.query(table);

      List<AcaoRobo> robos = List<AcaoRobo>();

      if (result.length > 0) {
        result.forEach((roboMap) async => {
          robos.add(AcaoRobo(
            id: roboMap['id'],
            robo: await RoboRepository.getById(int.parse(roboMap['id_robo'])),
            nome: roboMap['nome'],
            descricao: roboMap['descricao'],
            createdAt: DateHelper.secondsToDateTime(roboMap['createdAt'] ?? 0),
            updatedAt: DateHelper.secondsToDateTime(roboMap['updatedAt'] ?? 0),
            deletedAt: DateHelper.secondsToDateTime(roboMap['deletedAt'] ?? 0)
          ))
        });
      }

      return Future.value(robos);
  }

  static Future<AcaoRobo> getById(int id) async {
    Database db = await _conexao.database;

    List<Map<String, dynamic>> result = await db.query(table, where: 'id = ?', whereArgs: [id]);

    if (result.length != 0) {
      Map<String, dynamic> roboMap = result.first;
      return Future.value(AcaoRobo(
        id: roboMap['id'],
        robo: await RoboRepository.getById(int.parse(roboMap['id_robo'])),
        nome: roboMap['nome'],
        descricao: roboMap['descricao'],
        createdAt: DateHelper.secondsToDateTime(roboMap['createdAt'] ?? 0),
        updatedAt: DateHelper.secondsToDateTime(roboMap['updatedAt'] ?? 0),
        deletedAt: DateHelper.secondsToDateTime(roboMap['deletedAt'] ?? 0)
      ));
    }

    return Future.value(null);
  }

}