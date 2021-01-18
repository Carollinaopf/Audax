import 'dart:async';
import 'dart:io';
import 'package:loja_audax/Objects/products.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper{
  static DataBaseHelper _baseHelper;
  static Database _database;

  String cartTable = 'cartTable';
  String cartID = 'id';
  String cartUserID = 'userID';
  String cartName = 'name';
  String cartPrice = 'price';
  String cartImage = 'image';

  DataBaseHelper._createInstance();

  factory DataBaseHelper(){
    if(_baseHelper == null) {
      _baseHelper = DataBaseHelper._createInstance();
    }
    return _baseHelper;
  }

  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var directory = await getDatabasesPath();
    String path = directory + 'cart.db';

    var cartDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return cartDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $cartTable($cartID TEXT, '
        '$cartName TEXT, $cartUserID TEXT, $cartPrice TEXT, $cartImage TEXT)');
  }

  Future<int> insertProductCart(Products p) async {

    Database db = await this.database;

    var resultado = await db.insert(cartTable, p.toJson());

    return resultado;
  }

}