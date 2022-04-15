class User {
  int? id;
  String? email;
  String? username;
  String? phone;
  String? picture;
  String? language;
  String? location;
  String? aboutMe;
  String? userType;
  DateTime? dateJoined;

  User({
    this.id,
    this.email,
    this.username,
    this.phone,
    this.picture,
    this.language,
    this.location,
    this.aboutMe,
    this.userType,
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
    userType = json['user_type'];
    dateJoined = DateTime.parse(json['date_joined']);
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
    data['user_type'] = userType;
    return data;
  }
}
