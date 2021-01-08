import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loja_audax/Objects/user.dart';


class LoginApi{
  static Future<User> login(String email,
      String password) async {

    var url = 'https://market-ws.herokuapp.com/user/login';

    var header = {"Content-Type" : "application/json"};

    Map params = {
      "email" : email,
      "password" : password
    };
    var usuario;

    var _body = json.encode(params);
    print("json enviado : $_body");

    var response = await http.post(url, headers:header,
        body: _body);

    print('Response status: ${response.statusCode}');

    Map mapResponse = json.decode(response.body);

    if(response.statusCode == 200){
      usuario = User.fromJson(mapResponse);
    }else{
      usuario = null;
    }
    return usuario;

  }
}