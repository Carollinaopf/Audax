import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_audax/API/loginAPI.dart';
import 'package:loja_audax/cart.dart';
import 'package:loja_audax/list.dart';
import 'package:loja_audax/login.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:loja_audax/register.dart';
import 'package:loja_audax/splash.dart';

import 'Objects/user.dart';


void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/list': (context) => ListPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/cart': (context) => CartPage()
      },
    );
  }



}

