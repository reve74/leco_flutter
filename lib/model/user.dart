class UserModel {
  final String? uid;
  final String? email;
  final String? password;
  final String? username;
  // final String? photoUrl;

  UserModel({this.uid, this.email,this.password, this.username});


  // TODO: 파이어베이스 업로드 시 uid로 값이 모두 업로드 되는 현상
  // factory UserModel.fromMap(Map<String, dynamic> json) {
  //   return UserModel(
  //     uid: json['uid']== null ? '' : json['uid'] as String,
  //     email: json['email'] == null ? '' : json['uid'] as String,
  //     password: json['password'] == null ? '' : json['uid'] as String,
  //     username: json['username'] == null ? '' : json['uid'] as String,
  //     // photoUrl: data['photoUrl'] ?? '',
  //   );
  // }

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      username: data['username'] ?? '',
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