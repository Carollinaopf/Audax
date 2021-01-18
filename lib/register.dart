import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:loja_audax/API/registerAPI.dart';
import 'package:loja_audax/login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool hiddenPassword = true;
  bool hiddenPasswordI = true;

  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _cPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Cadastre-se!', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
            child: ListView(
              children: <Widget> [
                Column(
                children: [
                  Column(
                    children: [
                      TextFormField(keyboardType: TextInputType.name,
                        controller: _name,
                        style: new TextStyle(color: Colors.white, fontSize: 14),
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          labelStyle: TextStyle(color: Colors.white),
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
                      TextFormField(keyboardType: TextInputType.emailAddress,
                        controller: _email,
                        style: new TextStyle(color: Colors.white, fontSize: 14),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
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
                        obscureText: hiddenPassword,
                        controller: _password,
                        style: new TextStyle(color: Colors.white, fontSize: 14),
                        decoration: InputDecoration(
                            labelText: 'Senha',
                            labelStyle: TextStyle(color: Colors.white),
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
                  Divider(),
                  Column(
                    children: [
                      TextFormField(keyboardType: TextInputType.visiblePassword,
                        obscureText: hiddenPasswordI,
                        controller: _cPassword,
                        style: new TextStyle(color: Colors.white, fontSize: 14),
                        decoration: InputDecoration(
                            labelText: 'Confirme sua senha',
                            labelStyle: TextStyle(color: Colors.white),
                            suffixIcon: IconButton(onPressed: (){
                              setState(() {
                                hiddenPasswordI = !hiddenPasswordI;
                              });},
                              color: Colors.white,
                              icon: Icon(hiddenPasswordI ? Icons.visibility_off : Icons.visibility),)
                        ),),
                      Container(
                        width: 400,
                        height: 0.5,

                        color: Colors.white,
                      )
                    ],
                  ),
                  SizedBox(height: 50),
                  Container (
                      width: 250,
                      child: ButtonTheme(
                        buttonColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                        child: RaisedButton(
                          onPressed: () => {
                            Navigator.of(context).pushReplacementNamed('/home')
                          },
                          child: Text("CADASTRAR",
                            style: TextStyle(color: Colors.black87),),
                        ),
                      )
                  ),
                  Container (
                      width: 100,
                      child: ButtonTheme(
                        buttonColor: Colors.black,
                        child: RaisedButton(
                          onPressed: () => {
                            btnRegister(context)
                          },
                          child: Text("Já tem uma conta? Login.",
                            style: TextStyle(color: Colors.white, fontSize: 10),),
                        ),
                      )
                  )
                ],
              ),
              ]
            ),
        ),
      ),
    );
  }

  btnRegister(BuildContext context) async{
    String name = _name.text;
    String email = _email.text;
    String password = _password.text;

    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    
    if(name == null || email == null || password == null){

    }
    else if(!regExp.hasMatch(email)){

    }
    else if(_cPassword.text == _password.text){

      bool registed = await RegisterAPI.Register(name, email, password);

      if(registed){
        showDialog(context: context,
            builder: (context){
              return AlertDialog(
                backgroundColor: Colors.black45,
                title: Text("Cadastro concluido com sucesso!", style: TextStyle(color: Colors.white)),
                actions: <Widget>[
                  Container (
                      width: 250,
                      child: ButtonTheme(
                        buttonColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                        child: RaisedButton(
                          onPressed: () => {
                            Navigator.of(context).pushReplacementNamed('/')
                          },
                          child: Text("LOGAR",
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
                title: Text("Email já utilizado!", style: TextStyle(color: Colors.white)),
                actions: <Widget>[
                  Container (
                      width: 250,
                      child: ButtonTheme(
                        buttonColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                        child: RaisedButton(
                          onPressed: () => {
                            Navigator.of(context).pushReplacementNamed('/register')
                          },
                          child: Text("TENTE NOVAMENTE",
                            style: TextStyle(color: Colors.black87),),
                        ),
                      )
                  ),
                ],
              );
            });
      }
    }
    else{
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              backgroundColor: Colors.black45,
              title: Text("Senhas não coincidem!", style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                Container (
                    width: 250,
                    child: ButtonTheme(
                      buttonColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                      child: RaisedButton(
                        onPressed: () => {
                          Navigator.of(context).pushReplacementNamed('/register')
                        },
                        child: Text("TENTE NOVAMENTE",
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
