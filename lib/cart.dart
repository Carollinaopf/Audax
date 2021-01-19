import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_audax/Objects/products.dart';
import 'package:loja_audax/login.dart';

import 'list.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Products> p = List<Products>();

  DataBaseHelper db = DataBaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Carrinho'),
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
                ListTile(leading: Icon(Icons.home, color: Colors.white,),
                  title: Text('Home', style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) {return new ListPage();}));
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
      body: ListView.builder(itemBuilder: (context, index){}),
    );
  }
}
