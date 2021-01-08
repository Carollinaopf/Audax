import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:loja_audax/API/productsAPI.dart';
import 'package:loja_audax/Objects/products.dart';
import 'dart:async';
import 'dart:convert';

import 'package:loja_audax/Objects/user.dart';
import 'package:loja_audax/details.dart';

// ignore: must_be_immutable
class ListPage extends StatefulWidget {
  User user;
  ListPage(this.user);


  @override
  _ListPageState createState() => _ListPageState(user);
}

class _ListPageState extends State<ListPage> {
  User user;

  _ListPageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search, color: Colors.white,),
              onPressed: null,
          ),
          IconButton(icon: Image.asset('assets/image/blaIcon.png'),
              onPressed: null),
          IconButton(icon: Icon(Icons.shopping_cart_outlined, color: Colors.white,),
              onPressed: null),
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
                  child: UserAccountsDrawerHeader(accountName: Text(user.name), accountEmail: Text(user.wallet.toString()),
                  decoration: BoxDecoration(color: Colors.black),),
                ),
                ListTile(leading: Icon(Icons.shopping_cart_outlined, color: Colors.white,),
                  title: Text('Carrinho', style: TextStyle(color: Colors.white),),
                  onTap: (){

                  },
                ),
                ListTile(leading: Icon(Icons.arrow_back_sharp, color: Colors.white,),
                  title: Text('Sair', style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Navigator.of(context).pushReplacementNamed('/');
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
          List<Products> products = snapshot.data;
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
              onTap:() => Navigator.of(context).push(new MaterialPageRoute(builder: (context) {return new DetailsPage(user, p);})),
              child: Card(
               color: Colors.black,
                  child: Row(
                    children: [
                      Container(
                          width: 167,
                          height: 116,
                          child: Image.asset('assets/image/${p.image}'),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.nome, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                          Text(p.cost.toString(), style: TextStyle(color: Colors.white, fontSize: 14),)
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
}
