import 'package:leco_flutter/model/user.dart';

class Post {
  final String? id;
  final String? title;
  final String? content;
  final UserModel? userModel;
  final String? uid;
  final DateTime? created;
  final String? image;
  // final int? likeCount;

  Post({
    this.id,
    this.title,
    this.content,
    this.userModel,
    this.uid,
    this.created,
    this.image,
  });

  factory Post.init(UserModel userModel) {
    var time = DateTime.now();
    return Post(
      title: '',
      content: '',
      userModel: userModel,
      uid: userModel.uid,
      image: '',
      created: time,
    );
  }

  factory Post.fromJson(String docId, Map<String, dynamic> json) {
    return Post(
      id: json['id'] == null ? '' : json['id'] as String,
      title: json['title'] == null ? '' : json['title'] as String,
      content: json['content'] == null ? '' : json['content'] as String,
      userModel: json['userModel'] == null ? null : UserModel.fromMap(json['userModel']),
      uid: json['uid'] == null ? '' : json['uid'] as String,
      created:
          json['created'] == null ? DateTime.now() : json['created'].toDate(),
      image: json['image'] == null ? '' : json['image'] as String,
    );
  }

  Post copyWith({
    String? id,
    String? image,
    String? title,
    String? content,
    UserModel? userModel,
    String? uid,
    DateTime? created,
  }) {
    return Post(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      content: content ?? this.content,
      userModel: userModel ?? this.userModel,
      uid: uid ?? this.uid,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'userModel': userModel!.toJson(),
      'created': created,
      'image': image,
    };
  }
}
