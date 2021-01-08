import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loja_audax/Objects/products.dart';


class ProdutosApi{

  static Future<List<Products>> getProducts() async {

    var url = "https://market-ws.herokuapp.com/product/list";

    var response = await http.get(url);

    List listaResponse = json.decode(response.body);

    final produtos = List<Products>();

    for(Map map in listaResponse){
      Products p = Products.fromJson(map);
      print(map.toString());
      produtos.add(p);
    }
    return produtos;
  }
}