import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterAPI{
  static Future<bool> Register(String nome, String email,
      String password) async {

    var url = 'https://market-ws.herokuapp.com/user/register';

    var header = {"Content-Type" : "application/json"};

    Map params = {
      "name" : nome,
      "email" : email,
      "password" : password
    };
    bool registed = false;

    var _body = json.encode(params);
    print("json enviado : $_body");

    var response = await http.post(url, headers:header,
        body: _body);

    print('Response status: ${response.statusCode}');

    if(response.statusCode == 200){
      registed = true;
    }
    return registed;

  }
}