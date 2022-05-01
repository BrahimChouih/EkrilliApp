import '../data/api/api.dart';

class City {
  int? id;
  String? name;
  String? picture;

  City({this.id, this.name, this.picture});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picture = !json['picture'].contains(api)
        ? api + json['picture']
        : json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['picture'] = picture;
    return data;
  }
}
