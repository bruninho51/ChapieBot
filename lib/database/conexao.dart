import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Conexao {

  Conexao._privateConstructor(); // Construtor vazio privado

  static final _databaseName = "chap_flutter.db";
  static final _databaseVersion = 3;

  static final Conexao _instance = Conexao._privateConstructor();

  static Database _database;

  static Conexao get instance => _instance;

  // get para pegar a instancia de Database do Sqflite
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();

    return _database;

  }

  // Cria o arquivo de banco de dados
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate
    );
  }

  // Código DDL para criar o banco de dados
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE robo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome VARCHAR(200) NOT NULL,
        cor VARCHAR(200) NOT NULL,
        imagem VARCHAR(200),
        createdAt DATETIME NOT NULL,
        updatedAt DATETIME,
        deletedAt DATETIME
      )
    ''');

    await db.execute('''
      CREATE TABLE acao(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_robo INTEGER NOT NULL,
        nome VARCHAR(200) NOT NULL,
        descricao VARCHAR(200) NOT NULL,
        createdAt DATETIME NOT NULL,
        updatedAt DATETIME,
        deletedAt DATETIME
      )
    ''');

    await db.execute('''
      CREATE TABLE execucao(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_acao INTEGER NOT NULL,
        createdAt DATETIME NOT NULL,
        updatedAt DATETIME,
        deletedAt DATETIME
      )
    ''');
  }

}