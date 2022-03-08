import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import 'avatar_widget.dart';
import 'image_data.dart';

class ReviewCard extends StatefulWidget {
  ReviewCard({Key? key, this.number}) : super(key: key);
  int? number;

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AvatarWidget(
            type: AvatarType.TYPE3,
            nickName: 'jian_chae',
            thumbPath:
                'https://mblogthumb-phinf.pstatic.net/MjAxOTExMTJfNDgg/MDAxNTczNTM4MDA3NTg0.9TlIFX298qmFgshn'
                    'aDaEzIbsjbCv3Vv--lVKXYDncJUg.FDj0vS33LWuKyQGof7MZ0wNHFgCPYTkgtyhGq8fVsLIg.JPEG.b-seol/67169559_300723540773498_6905365256298412426_n.jpg?type=w800',
            size: 30,
          ),
          Text('2022-02-23'),
        ],
      ),
    );
  }

  Widget image() {
    return CachedNetworkImage(
        imageUrl:
            'https://www.lego.com/cdn/cs/set/assets/blt62f99776b13a8e94/10297.png?fit=bounds&format=png&width=1500&height=1500&dpr=1');
  }

  Widget _infoDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '좋아요 200개',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          ExpandableText(
            '레고레고레고\n레고레고레고\n레고레고레고\n',
            prefixText: 'jian_chae',
            onPrefixTap: () {
              print('jian_chae 페이지 이동');
            },
            prefixStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            expandText: '더 보기',
            collapseText: '접기',
            maxLines: 3,
            expandOnTextTap: true,
            collapseOnTextTap: true,
            linkColor: Colors.grey,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _replyTextBtn() {
    return GestureDetector(
      onTap: () {},
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          '댓글 100개 모두 보기',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header(),
          SizedBox(
            height: size.height * 0.01,
          ),
          image(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                ImageData(
                  IconsPath.likeOffIcon,
                  width: 65,
                ),
                const SizedBox(
                  width: 10,
                ),
                ImageData(
                  IconsPath.replyIcon,
                  width: 60,
                ),
              ],
            ),
          ),
          _infoDescription(),
          _replyTextBtn(),
        ],
      ),
    );
  }
}
