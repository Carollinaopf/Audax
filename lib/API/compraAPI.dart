import 'dart:convert';
import 'package:http/http.dart' as http;

class PurchaseAPI{
  static Future<bool> Purchase(String userId, String productId) async {

    var url = 'https://market-ws.herokuapp.com/product/purchase';

    var header = {"Content-Type" : "application/json"};

    Map params = {
      "user_id": userId,
      "product_id": productId
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