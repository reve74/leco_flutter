import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leco_flutter/controller/upload_controller.dart';
import 'package:leco_flutter/model/post.dart';
import 'package:leco_flutter/settings/firebase.dart';

import 'avatar_widget.dart';
import 'image_data.dart';

class ReviewCard extends StatelessWidget {
  UploadController u = Get.put(UploadController());
  ReviewCard({Key? key, required this.post}) : super(key: key);

  final Post post;

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AvatarWidget(
            type: AvatarType.TYPE3,
            nickName: post.userModel!.username,
            thumbPath:
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
            size: 30,
          ),
          if(auth.currentUser!.uid == post.userModel!.uid)
          IconButton(
              onPressed: () {
                showDialog(
                  context: Get.context!,
                  builder: (context) => Dialog(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shrinkWrap: true,
                      children: ['삭제하기']
                          .map(
                            (e) => InkWell(
                              onTap: () async {
                                u.deletePost(post.id!);
                                Get.back();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                child: Text(e),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
    );
  }

  Widget image() {
    return CachedNetworkImage(imageUrl: post.image!);
  }

  Widget _infoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Text(
            post.title!, style: const TextStyle(
             fontWeight: FontWeight.w600
           ),
          ),
          SizedBox(height: 5,),
          ExpandableText(
            post.content ?? '',
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // const Text(
            //   '댓글 100개 모두 보기',
            //   style: TextStyle(
            //     color: Colors.grey,
            //     fontSize: 13,
            //   ),
            // ),
            Text(
              DateFormat.yMMMd().format(
                post.created!,
              ),
            ),
          ],
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //   child: Row(
          //     children: [
          //       ImageData(
          //         IconsPath.likeOffIcon,
          //         width: 65,
          //       ),
          //       const SizedBox(
          //         width: 10,
          //       ),
          //       ImageData(
          //         IconsPath.replyIcon,
          //         width: 60,
          //       ),
          //     ],
          //   ),
          // ),
          _infoDescription(),
          _replyTextBtn(),
        ],
      ),
    );
  }
}
