import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_audax/Helper/dataBaseHelper.dart';
import 'package:loja_audax/Objects/products.dart';
import 'package:loja_audax/Objects/user.dart';

import 'API/compraAPI.dart';
import 'list.dart';
import 'login.dart';

class DetailsPage extends StatefulWidget {
  Products p;

  DetailsPage(this.p);

  @override
  _DetailsPageState createState() => _DetailsPageState(p);
}

class _DetailsPageState extends State<DetailsPage> {
  Products p;
  DataBaseHelper db = DataBaseHelper();

  _DetailsPageState(this.p);
  @override
  Widget build(BuildContext context) {
    Future<bool> exists = db.cartExists(p.sId);
    
    return FutureBuilder(
      future: exists,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else {
          bool exists = snapshot.data;
          return Scaffold(
            backgroundColor: Colors.black87,
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_sharp), onPressed: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) {
                      return new ListPage();
                    }));
              },),
            ),

            body: ListView(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: 360,
                            height: 225,
                            child: Image.network(
                                'https://market-ws.herokuapp.com/uploads/${p
                                    .image}'),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.nome, style: TextStyle(color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat')),
                            Divider(),
                            Text(p.cost.toString(), style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Lato')),
                          ],
                        )),
                        SizedBox(height: 60,),
                        Container(
                            width: 250,
                            child: ButtonTheme(
                              buttonColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              child: RaisedButton(
                                onPressed: () =>
                                {
                                  showDialog(context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.black45,
                                          title: Text(
                                              "Deseja confirmar a compra?",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          actions: <Widget>[
                                            Container(
                                                width: 250,
                                                child: ButtonTheme(
                                                  buttonColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(18.0)),
                                                  child: RaisedButton(
                                                    onPressed: () =>
                                                    {
                                                      btnPurchase(context)
                                                    },
                                                    child: Text(
                                                      "CONFIRMAR A COMPRA",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black87),),
                                                  ),
                                                )
                                            ),
                                          ],
                                        );
                                      })
                                },
                                child: Text("COMPRAR",
                                  style: TextStyle(color: Colors.black87),),
                              ),
                            )
                        ),
                        SizedBox(height: 5,),
                        Container(
                            width: 250,
                            child: ButtonTheme(
                              buttonColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              child: RaisedButton(
                                onPressed: () =>
                                {
                                  showDialog(context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.black45,
                                          title: Text(
                                              exists ? "Item removido do carrinho" : "Item adicionado ao carrinho",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          actions: <Widget>[
                                            Container(
                                                width: 250,
                                                child: ButtonTheme(
                                                  buttonColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(18.0)),
                                                  child: RaisedButton(
                                                    onPressed: () =>
                                                    {
                                                      if(exists){
                                                        db.deleteCartProduct(p.sId)
                                                      }
                                                      else {
                                                        db.insertProductCart(p)
                                                      },
                                                      Navigator.of(context).pop()
                                                    },
                                                    child: Text("FECHAR",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black87),),
                                                  ),
                                                )
                                            ),
                                          ],
                                        );
                                      })
                                },
                                child: Text(exists ? "REMOVER DO CARRINHO" : "ADICIONAR AO CARRINHO",
                                  style: TextStyle(color: Colors.black87),),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }
    );
  }

  btnPurchase(BuildContext context) async {
      bool done = await PurchaseAPI.Purchase(LoginPage.user.sId, p.sId);
      var result;
      print(p.sId);
      if(done){
        showDialog(context: context,
            builder: (context){
              return AlertDialog(
                backgroundColor: Colors.black45,
                title: Text("Compra realizada com sucesso", style: TextStyle(color: Colors.white)),
                actions: <Widget>[
                  Container (
                      width: 250,
                      child: ButtonTheme(
                        buttonColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                        child: RaisedButton(
                          onPressed: () => {
                            result = db.deleteCartProduct(p.sId),
                            Navigator.of(context).push(new MaterialPageRoute(builder: (context) {return new DetailsPage(p);}))
                          },
                          child: Text("FECHAR",
                            style: TextStyle(color: Colors.black87),),
                        ),
                      )
                  ),
                ],
              );
            });
      }
      else{
        showDialog(context: context,
            builder: (context){
              return AlertDialog(
                backgroundColor: Colors.black45,
                title: Text("Falha na compra", style: TextStyle(color: Colors.white)),
                actions: <Widget>[
                  Container (
                      width: 250,
                      child: ButtonTheme(
                        buttonColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                        child: RaisedButton(
                          onPressed: () => {
                            Navigator.of(context).push(new MaterialPageRoute(builder: (context) {return new DetailsPage(p);}))
                          },
                          child: Text("FECHAR",
                            style: TextStyle(color: Colors.black87),),
                        ),
                      )
                  ),
                ],
              );
            });
      }
    }
  }

