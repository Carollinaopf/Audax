import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:loja_audax/API/productsAPI.dart';
import 'package:loja_audax/Components/searchComponent.dart';
import 'package:loja_audax/Objects/products.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:loja_audax/Objects/user.dart';
import 'package:loja_audax/cart.dart';
import 'package:loja_audax/details.dart';
import 'package:loja_audax/login.dart';

// ignore: must_be_immutable
class ListPage extends StatefulWidget {

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Products> prod;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search, color: Colors.white,),
              onPressed: (){
                showSearch(context: context, delegate: ProductSearch(prod));
              },
          ),
          IconButton(icon: Image.asset('assets/image/blaIcon.png'),
              onPressed: null),
          IconButton(icon: Icon(Icons.shopping_cart_outlined, color: Colors.white,),
              onPressed: () => {Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) {return new CartPage();}))}),
        ],
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.black54),
        child: Drawer(
          child: Container(
            child: Column(
              children: [
                Theme(
                  data: Theme.of(context).copyWith(canvasColor: Colors.black54),
                  child: UserAccountsDrawerHeader(accountName: Text(LoginPage.user.name), accountEmail: Text(LoginPage.user.wallet.toString()),
                  decoration: BoxDecoration(color: Colors.black),),
                ),
                ListTile(leading: Icon(Icons.shopping_cart_outlined, color: Colors.white,),
                  title: Text('Carrinho', style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) {return new CartPage();}));
                  },
                ),
                ListTile(leading: Icon(Icons.arrow_back_sharp, color: Colors.white,),
                  title: Text('Sair', style: TextStyle(color: Colors.white),),
                  onTap: (){
                    cleanPrefenrences();
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: productList(),
    );
  }

  productList(){
    Future<List<Products>> products = ProdutosApi.getProducts();
    return FutureBuilder(
        future: products,
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          List<Products> products = snapshot.data;
          prod = products;
          return _listp(products);
        });
  }

  _listp(products){
    return Container(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
          itemCount: products != null ? products.length : 0,
          itemBuilder: (context, index){
            Products p = products[index];


            return GestureDetector(
              onTap:() => Navigator.of(context).push(new MaterialPageRoute(builder: (context) {return new DetailsPage(p);})),
              child: Card(
               color: Colors.black,
                  child: Row(
                    children: [
                      Container(
                          width: 167,
                          height: 116,
                          child: Image.network('https://market-ws.herokuapp.com/uploads/${p.image}'),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 120,
                              child: Text(p.nome, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),)),
                          Text(p.cost.toString(), style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Lato'),)
                        ],
                      ),
                      SizedBox(height: 5,)
                    ],
                  ),
                ),
            );
          }),
    );
  }

  cleanPrefenrences() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }
}
