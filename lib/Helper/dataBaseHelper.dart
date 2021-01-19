import 'dart:async';
import 'dart:io';
import 'dart:convert';
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
    await db.execute('CREATE TABLE IF NOT EXISTS $cartTable($cartID TEXT, '
        '$cartName TEXT, $cartUserID TEXT, $cartPrice INTEGER, $cartImage TEXT)');
  }

   Future<int> insertProductCart(Products p) async {
    Database db = await this.database;

    Map<String, dynamic> mapa = {
      cartID : p.sId,
      cartName : p.nome,
      cartPrice : p.cost,
      cartImage : p.image
    };

    print(mapa.toString());
    print("tentando inserir..");
    var resultado = await db.insert(cartTable, mapa);
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    print('resultado: $resultado.toString()');
    return resultado;
  }

   Future<List<Products>> getProductsCart() async {
    Database db = await this.database;

    List<Map> pCart = await db.rawQuery('SELECT * FROM $cartTable');

    print(pCart.toString());

    List<Products> productss = List<Products>();

    for(Map map in pCart){
      Products p = Products.fromJson(map);
      print(map.toString());
      productss.add(p);
    }
    print('está pegando');
    return productss;
  }


}