import 'package:leco_flutter/model/user.dart';

class Post {
  final String? title;
  final String? content;
  final UserModel? user;
  final DateTime? created;
  final DateTime? updated;

  Post({this.title, this.content, this.user, this.created, this.updated});


}