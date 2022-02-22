import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import 'image_data.dart';

class PostWidget extends StatelessWidget {
const PostWidget({Key? key}) : super(key: key);

// Widget _header() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 5.0),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         AvatarWidget(
//           type: AvatarType.TYPE3,
//           nickName: 'Charlie',
//           thumbPath:
//           'https://i.pinimg.com/originals/4f/fd/f4/4ffdf44d886b79b366c27486051a1081.png',
//           size: 30,
//         ),
//         GestureDetector(
//           onTap: () {},
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ImageData(
//               IconsPath.postMoreIcon,
//               width: 30,
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }

Widget _image() {
  return CachedNetworkImage(
      imageUrl: 'https://i.ytimg.com/vi/UAQT5Hgrm1Q/maxresdefault.jpg');
}

Widget _infoCount() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
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
            const SizedBox(
              width: 10,
            ),
            ImageData(
              IconsPath.directMessage,
              width: 55,
            ),
          ],
        ),
        ImageData(
          IconsPath.bookMarkOffIcon,
          width: 50,
        ),
      ],
    ),
  );
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
          '윈터윈터윈터윈터윈터윈터\n윈터윈터윈터\n윈터윈터윈터\n',
          prefixText: 'Charlie',
          onPrefixTap: () {
            print('찰리 페이지 이동');
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

Widget _dateAgo() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    child: Text(
      '1일 전',
      style: TextStyle(color: Colors.grey, fontSize: 13),
    ),
  );
}

@override
Widget build(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // _header(),
        const SizedBox(
          height: 7,
        ),
        _image(),
        const SizedBox(
          height: 7,
        ),
        _infoCount(),
        const SizedBox(
          height: 7,
        ),
        _infoDescription(),
        const SizedBox(
          height: 7,
        ),
        _replyTextBtn(),
        const SizedBox(
          height: 7,
        ),
        _dateAgo(),
      ],
    ),
  );
}
}
