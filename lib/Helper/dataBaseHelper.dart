import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:loja_audax/Objects/products.dart';
import 'package:loja_audax/Objects/user.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper{
  static DataBaseHelper _baseHelper;
  static Database _database;

  String cartTable = 'cartTable';
  String cartID = '_id';
  String cartUserID = 'userID';
  String cartName = 'name';
  String cartPrice = 'cost';
  String cartImage = 'image';

  String userTable = 'userTable';
  String userID = '_id';
  String userName = 'name';
  String userPassword = 'password';
  String wallet = 'wallet';

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
    print('printando');
    var directory = await getDatabasesPath();
    String path = directory + 'cart.db';

    var cartDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    print('printando22');
    return cartDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    List<String> q = [
      "CREATE TABLE IF NOT EXISTS $cartTable($cartID TEXT, $cartName TEXT, $cartUserID TEXT, $cartPrice INTEGER, $cartImage TEXT);",
      "CREATE TABLE IF NOT EXISTS $userTable($userID TEXT, $userName TEXT, $userPassword TEXT, $wallet INTEGER)",
    ];

    for(String que in q){
      await db.execute(que);
    }
    print('criou');
  }

   Future<int> insertProductCart(Products p) async {
    Database db = await this.database;

    Map<String, dynamic> mapa = {
      cartID : p.sId,
      cartName : p.nome,
      cartPrice : p.cost,
      cartImage : p.image
    };

    var resultado = await db.insert(cartTable, mapa);
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
    return productss;
  }

  Future<bool> cartExists(String id) async{
    var db = await this.database;

    List<Map> map = await db.query(cartTable, columns: [cartID], where: "$cartID = ?", whereArgs: [id]);

    if(map.length > 0){
      return true;
    }
    else {
      return false;
    }
  }

  Future<int> deleteCartProduct(String id) async{
    var db = await this.database;

    print('tentando excluir');
    int resultado = await db.delete(cartTable, where: "$cartID = ?", whereArgs: [id]);
    print('resultado: $resultado');
    return resultado;
  }

  Future<int> saveUser(User u) async{
    var db = await this.database;

    Map<String, dynamic> mapa = {
      userID : u.sId,
      userName : u.name,
      userPassword : u.password,
      wallet : u.wallet
    };

    var resultado = await db.insert(userTable, mapa);

    return resultado;
  }

  Future<User> searchUser() async{
    var db = await this.database;

    List<Map> u = await db.rawQuery('SELECT * FROM $userTable');
    List<User> user = List<User>();

    for(Map map in u){
      User p = User.fromJson(map);
      print(map.toString());
      user.add(p);
    }
    return user.first;
  }

  void deleteUser() async{
    var db = await this.database;
    List<Map> i = await db.rawQuery('DELETE * FROM $userTable');
  }
}