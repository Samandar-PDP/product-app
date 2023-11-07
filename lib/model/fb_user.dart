class FbUser {
  String? uid;
  String? date;
  String? image;
  String? password;
  String? email;

  FbUser.fromJson(Map<String, dynamic> json) :
      uid = json['id'],
  date = json['date'],
  image = json['image'],
  password = json['password'],
  email = json['email'];
}