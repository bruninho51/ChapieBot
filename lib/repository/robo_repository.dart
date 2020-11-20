import 'package:chap_flutter/model/cor_robo.dart';
import 'package:sqflite/sqlite_api.dart';
import '../model/robo.dart';
import '../database/conexao.dart';
import '../util/date_helper.dart';

class RoboRepository {

  static final Conexao _conexao = Conexao.instance;

  static final String table = 'robo';

  static Future<int> save(Robo robo) async {
      Database db = await _conexao.database;

      return await db.insert(table, {
        'nome': robo.nome,
        'cor': robo.cor.id.toString(),
        'createdAt': DateHelper.currentTimeInSeconds()
      });
  }

  static Future<int> update(Robo robo) async {
      Database db = await _conexao.database;

      return await db.update(table, {
        'nome': robo.nome,
        'cor': robo.cor.id.toString(),
        'updatedAt': DateHelper.currentTimeInSeconds()
      }, where: 'id = ?', whereArgs: [robo.id]);
  }

  static Future<List<Robo>> getAll() async {
      Database db = await _conexao.database;

      List<Map<String, dynamic>> result = await db.query(table);

      List<Robo> robos = List<Robo>();

      if (result.length > 0) {
        result.forEach((roboMap) => {
          robos.add(Robo(
            id: roboMap['id'],
            nome: roboMap['nome'],
            cor: CorRobo.getColorById(int.parse(roboMap['cor'])),
            createdAt: DateHelper.secondsToDateTime(roboMap['createdAt'] ?? 0),
            updatedAt: DateHelper.secondsToDateTime(roboMap['updatedAt'] ?? 0),
            deletedAt: DateHelper.secondsToDateTime(roboMap['deletedAt'] ?? 0)
          ))
        });
      }

      return Future.value(robos);
  }

  static Future<Robo> getById(int id) async {
    Database db = await _conexao.database;

    List<Map<String, dynamic>> result = await db.query(table, where: 'id = ?', whereArgs: [id]);

    if (result.length != 0) {
      Map<String, dynamic> roboMap = result.first;
      return Future.value(Robo(
        id: roboMap['id'],
        nome: roboMap['nome'],
        cor: CorRobo.getColorById(int.parse(roboMap['cor'])),
        createdAt: DateHelper.secondsToDateTime(roboMap['createdAt'] ?? 0),
        updatedAt: DateHelper.secondsToDateTime(roboMap['updatedAt'] ?? 0),
        deletedAt: DateHelper.secondsToDateTime(roboMap['deletedAt'] ?? 0)
      ));
    }

    return Future.value(null);
  }

}