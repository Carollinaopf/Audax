import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:loja_audax/API/loginAPI.dart';
import 'package:loja_audax/list.dart';

import 'Objects/user.dart';

class LoginPage extends StatefulWidget {
  static User user;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool hiddenPassword = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 140,
                  height: 164,
                  child: Image.asset('assets/image/logo.png'),
                ),
                Divider(),
                Column(
                  children: [
                    TextFormField(keyboardType: TextInputType.emailAddress,
                      controller: email,
                      style: new TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Lato'),
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: TextStyle(color: Colors.white, fontFamily: 'Lato'),
                        border: UnderlineInputBorder(),
                      ),),
                    Container(
                      width: 400,
                      height: 0.5,

                      color: Colors.white,
                    )
                  ],
                ),
                Divider(),
                Column(
                  children: [
                    TextFormField(keyboardType: TextInputType.visiblePassword,
                      controller: password,
                      obscureText: hiddenPassword,
                      style: new TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(color: Colors.white, fontFamily: 'Lato'),
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              hiddenPassword = !hiddenPassword;
                            });},
                            color: Colors.white,
                            icon: Icon(hiddenPassword ? Icons.visibility_off : Icons.visibility),)
                      ),),
                    Container(
                      width: 400,
                      height: 0.5,

                      color: Colors.white,
                    )
                  ],
                ),
                SizedBox(height: 50,),
                Container (
                    width: 250,
                    child: ButtonTheme(
                      buttonColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                      child: RaisedButton(
                        onPressed: () => {
                          btnLogin(context)
                        },
                        child: Text("ENTRAR",
                          style: TextStyle(color: Colors.black87, fontFamily: 'Lato'),),
                      ),
                    )
                ),
                Container (
                    width: 100,
                    child: ButtonTheme(
                      buttonColor: Colors.black,
                      child: RaisedButton(
                        onPressed: () => {
                          Navigator.of(context).pushNamed('/register')
                        },
                        child: Text("Cadastre-se",
                          style: TextStyle(color: Colors.white, fontSize: 8, fontFamily: 'Lato'),),
                      ),
                    )
                )
              ],
            ),
          )
      ),
    );
  }

  btnLogin(BuildContext context) async {
    String e = email.text;
    String p = password.text;


    LoginPage.user = await LoginApi.login(e, p);

    if(LoginPage.user != null){
      print(LoginPage.user.name);
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) {return new ListPage();}));
    }
    else{
      showDialog(context: context,
          builder: (context){
        return AlertDialog(
          backgroundColor: Colors.black45,
          title: Text("Usuário não existe.", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            Container (
                width: 250,
                child: ButtonTheme(
                  buttonColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                  child: RaisedButton(
                    onPressed: () => {
                      Navigator.of(context).pop()
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
