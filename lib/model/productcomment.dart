import 'package:leco_flutter/model/user.dart';

class ProductComment {
  final String? comment;
  final String? modelNumber;
  final UserModel? user;
  final DateTime? created;
  final double? starCount;

  ProductComment(
      {this.comment,
      this.modelNumber,
      this.user,
      this.created,
      this.starCount});

  ProductComment.fromJson(Map<String, dynamic> json)
      : comment = json['comment'],
        modelNumber = json['modelNumber'],
        user = UserModel.fromMap(json['user']),
        created = json['created'].toDate(),
        starCount = json['starCount'].toDouble();

  Map<String, Object?> toJson() {
    return {
      'comment': comment,
      'modelNumber': modelNumber,
      'user': user!.toJson(),
      'created': created,
      'starCount': starCount,
    };
  }
}
