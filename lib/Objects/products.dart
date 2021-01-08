class Products {
  String sId;
  String nome;
  String image;
  int cost;

  Products({this.sId, this.nome, this.cost});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nome = json['name'];
    image = json['image'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.nome;
    data['image'] = this.image;
    data['cost'] = this.cost;
    return data;
  }
}