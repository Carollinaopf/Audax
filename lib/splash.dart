import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_audax/list.dart';
import 'package:loja_audax/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loja_audax/login.dart';
import 'package:splashscreen/splashscreen.dart';

import 'API/loginAPI.dart';
import 'Objects/user.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState(){
    super.initState();

    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }


   getPreferences() async{
    SharedPreferences sp = await SharedPreferences.getInstance();

    bool logado = sp.getBool("logado") ?? false;

    if(logado){
      String email = sp.getString('email');
      String password = sp.getString('password');

      User user = await LoginApi.login(email, password);
      LoginPage.user = user;

      Navigator.of(context).pushReplacementNamed('/list');
    }
    else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }


}
