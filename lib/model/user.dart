class UserModel {
  final String? uid;
  final String? email;
  final String? password;
  final String? username;
  // final String? photoUrl;

  UserModel({this.uid, this.email,this.password, this.username});

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid']== null ? '' : json['uid'] as String,
      email: json['email'] == null ? '' : json['uid'] as String,
      password: json['password'] == null ? '' : json['uid'] as String,
      username: json['username'] == null ? '' : json['uid'] as String,
      // photoUrl: data['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "password": password,
    "username": username,
    // "photoUrl": photoUrl
  };
}