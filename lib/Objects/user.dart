class User {
  String sId;
  String name;
  String password;
  int wallet;

  User({this.sId, this.name, this.password, this.wallet});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    password = json['password'];
    wallet = json['wallet'];
  }

  String getName(){
    return this.name;
  }
  String getEmail(){
    return this.wallet.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['password'] = this.password;
    data['wallet'] = this.wallet;
    return data;
  }
}

