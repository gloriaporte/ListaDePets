import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../model/pet.dart';

class DbHelper {
  // Atributos
  String tblPet = 'pet';
  String colId = 'id';
  String colNome = 'nome';
  String colSexo = 'sexo';
  String colTipo = 'tipo';
  String colIdade = 'idade';
  String colAnoAdotado = 'anoAdotado';
  String colVacinado = 'vacinado';
  String colCastrado = 'castrado';

  // Referência para o banco de dados
  static Database? _db;

  // Construtor
  DbHelper._internal();

  // Atributo privado, ligado à classe
  static final DbHelper _dbHelper = DbHelper._internal();

  // Retornar uma referência válida
  factory DbHelper() {
    return _dbHelper;
  }

  // Método que retorna objeto Future da classe Database
  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'pets.db';
    var dbPets = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbPets;
  }

  // Método que cria o banco de dados
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tblPet('
            '$colId INTEGER PRIMARY KEY,'
            '$colNome TEXT,'
            '$colSexo TEXT,'
            '$colTipo TEXT,'
            '$colIdade INTEGER,'
            '$colAnoAdotado INTEGER,'
            '$colVacinado BOOLEAN,'
            '$colCastrado BOOLEAN'
            ')'
    );
  }

  // Criar um método para retornar o banco de dados
  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initializeDb();
      return _db!;
    }
  }

  // Método para inserir um pet
  Future<int> insertPet(Pet pet) async {
    Database db = await this.db;

    var result = await db.insert(tblPet, pet.toMap());
    return result;
  }

  // Método para retornar a lista de pets
  Future<List> getPets() async {
    Database db = await this.db;

    var result = await db.query(tblPet, orderBy: colId);
    return result;
  }

  // Método para retornar int do número de pets na tabela
  Future<int> getCount() async {
    Database db = await this.db;

    var result = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tblPet')
    );
    return result!;
  }

  // Método para atualizar um pet
  Future<int> updatePet(Pet pet) async {
    Database db = await this.db;

    var result = await db.update(tblPet, pet.toMap(), where: '$colId = ?', whereArgs: [pet.id]);
    return result;
  }

  // Método para deletar um pet
  Future<int> deletePet(int id) async {
    Database db = await this.db;

    var result = await db.delete(tblPet, where: '$colId = ?', whereArgs: [id]);
    return result;
  }
}
