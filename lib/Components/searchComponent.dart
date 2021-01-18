import 'package:flutter/material.dart';
import 'package:loja_audax/Objects/products.dart';
import '../details.dart';

class ProductSearch extends SearchDelegate<String>{
  List<Products> ps;

  ProductSearch(this.ps);


  @override
  List<Widget> buildActions(BuildContext context) {
    return[
      IconButton(icon: Icon(Icons.clear), onPressed: (){query = "";})
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.arrow_menu, progress: transitionAnimation), onPressed: (){close(context, null);});
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = new List(ps.length);
    for(int i = 0; i < ps.length; i++){
      suggestions[i] = ps[i].nome;
    }

    final suggestionList = suggestions.where((p) => p.toLowerCase().startsWith(query)).toList();
    return ListView.builder(itemBuilder: (context, index) => ListTile(title: Text(suggestionList[index]),
      onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) {return new DetailsPage(ps[index]);})),),
        itemCount: suggestionList.length);}
  
}