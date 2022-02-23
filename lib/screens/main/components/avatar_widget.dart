import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum AvatarType { TYPE1, TYPE2, TYPE3 } // 아바타 타입

class AvatarWidget extends StatelessWidget {
  String? thumbPath;
  String? nickName;
  double? size;

  AvatarWidget({
    Key? key,
    required this.thumbPath,
    this.nickName,
    this.size = 60,
  }) : super(key: key);

  Widget type1Widget() {
    // 타입1 위젯(다른사람 스토리)
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.all(1),
      decoration: const BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        //   colors: [
        //     Colors.purple,
        //     Colors.orange,
        //   ],
        // ),
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      child: type2Widget(),
    );
  }

  Widget type2Widget() {
    // 타입2 위젯(내 스토리)
    return Container(
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size!),
          child: SizedBox(
            width: size,
            height: size,
            child: CachedNetworkImage(
              imageUrl: thumbPath!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget type3Widget() {
    // 게시물 위젯
    return Row(
      children: [
        type1Widget(),
        Text(
          nickName ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return type3Widget();
  }
}