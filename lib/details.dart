import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_audax/Objects/products.dart';
import 'package:loja_audax/Objects/user.dart';

import 'API/compraAPI.dart';
import 'list.dart';

class DetailsPage extends StatefulWidget {
  User user;
  Products p;

  DetailsPage(this.user, this.p);

  @override
  _DetailsPageState createState() => _DetailsPageState(user, p);
}

class _DetailsPageState extends State<DetailsPage> {
  User user;
  Products p;

  _DetailsPageState(this.user, this.p);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: Icon(Icons.arrow_back_sharp), onPressed: () {Navigator.of(context).push(new MaterialPageRoute(builder: (context) {return new ListPage(user);}));},),
      ),

      body: Container(
        child: Column(
          children: [
            Center(
              child: Container(
                  width: 360,
                  height: 225,
                  child: Image.asset('assets/image/${p.image}'),
              ),
            ),
            SizedBox(height: 30,),
            Container(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.nome, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                Divider(),
                Text(p.cost.toString(), style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            )),
            SizedBox(height: 60,),
            Container (
                width: 250,
                child: ButtonTheme(
                  buttonColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                  child: RaisedButton(
                    onPressed: () => {
                      showDialog(context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      backgroundColor: Colors.black45,
                                      title: Text("Deseja confirmar a compra?", style: TextStyle(color: Colors.white)),
                                      actions: <Widget>[
                                        Container (
                                            width: 250,
                                            child: ButtonTheme(
                                              buttonColor: Colors.white,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                                              child: RaisedButton(
                                                onPressed: () => {
                                                  btnPurchase(context)
                                                },
                                                child: Text("CONFIRMAR A COMPRA",
                                                  style: TextStyle(color: Colors.black87),),
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
          ],
        ),
      ),
    );
  }

  btnPurchase(BuildContext context) async {
      bool done = await PurchaseAPI.Purchase(user.sId, p.sId);

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
                            Navigator.of(context).push(new MaterialPageRoute(builder: (context) {return new DetailsPage(user, p);}))
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
                            Navigator.of(context).push(new MaterialPageRoute(builder: (context) {return new DetailsPage(user, p);}))
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

