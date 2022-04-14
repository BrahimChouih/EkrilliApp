class Favorite {
  int? id;
  DateTime? createdAt;
  String? house;
  String? user;

  Favorite({this.id, this.createdAt, this.house, this.user});

  Favorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = DateTime.parse(json['created_at']);
    house = json['house'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['house'] = house;
    data['user'] = user;
    return data;
  }
}
