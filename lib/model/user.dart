class UserModel {
  final String? uid;
  final String? email;
  final String? password;
  final String? username;
  final String? photoUrl;

  UserModel({this.uid, this.email,this.password, this.username, this.photoUrl});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      username: data['username'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "password": password,
    "username": username,
    "photoUrl": photoUrl
  };
}