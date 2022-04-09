class User {
  int? id;
  String? email;
  String? username;
  String? phone;
  String? picture;
  String? language;
  String? location;
  String? aboutMe;
  String? dateJoined;

  User({
    this.id,
    this.email,
    this.username,
    this.phone,
    this.picture,
    this.language,
    this.location,
    this.aboutMe,
    this.dateJoined,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    picture = json['picture'];
    language = json['language'];
    location = json['location'];
    aboutMe = json['about_me'];
    dateJoined = json['date_joined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['username'] = username;
    data['phone'] = phone;
    data['picture'] = picture;
    data['language'] = language;
    data['location'] = location;
    data['about_me'] = aboutMe;
    return data;
  }
}
