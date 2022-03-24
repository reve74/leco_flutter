import 'package:leco_flutter/model/user.dart';

class Post {
  final String? id;
  final String? title;
  final String? content;
  final UserModel? user;
  final DateTime? created;
  final String? image;

  Post({this.id,this.title, this.content, this.user, this.created, this.image});

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        user = UserModel.fromMap(json['user']),
        created = json['created'].toDate(),
        image = json['image'];

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'user': user!.toJson(),
      'created': created,
      'image': image,
    };
  }
}
