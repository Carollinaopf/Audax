import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_audax/Objects/products.dart';
import 'package:loja_audax/login.dart';
import 'Helper/dataBaseHelper.dart';
import 'details.dart';
import 'list.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  DataBaseHelper db = DataBaseHelper();
  List<Products> prod;

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
                  child: UserAccountsDrawerHeader(
                    accountName: Text(LoginPage.user.name),
                    accountEmail: Text(LoginPage.user.wallet.toString()),
                    decoration: BoxDecoration(color: Colors.black),),
                ),
                ListTile(leading: Icon(Icons.home, color: Colors.white,),
                  title: Text('Home', style: TextStyle(color: Colors.white),),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        new MaterialPageRoute(builder: (context) {
                          return new ListPage();
                        }));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.arrow_back_sharp, color: Colors.white,),
                  title: Text('Sair', style: TextStyle(color: Colors.white),),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: productCartList(),
    );
  }
    productCartList(){
    print('está entrando');
      Future<List<Products>> products = db.getProductsCart();
      return FutureBuilder(
          future: products,
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            List<Products> products = snapshot.data;
            prod = products;
            print(products);
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
}
