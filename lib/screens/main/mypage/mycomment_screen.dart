import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/product_comment_controller.dart';
import 'package:leco_flutter/settings/firebase.dart';

class MyCommentScreen extends GetView<ProductCommentController> {
  MyCommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: firebaseFirestore
            .collection('productComments')
            .doc('10297')
            .collection('comments')
            // .where('uid', isEqualTo: auth.currentUser!.uid)
            .orderBy('created', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          final docs = (snapshot.data! as dynamic).docs;
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: docs.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //TODO: dateformating 필요
                    // Text(DateFormat.yMMMd().format(docs[index]['created'])),
                    Row(
                      children: [
                        Text(docs[index]['created'].toDate().toString()),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            // controller.delete(
                            //     modelNumber: widget.subCategory!.modelNumber!,
                            //     uid: auth.currentUser!.uid);
                          },
                          child: Text('삭제'),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(docs[index]['username']),
                    ),
                    RatingBarIndicator(
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      rating: docs[index]['starCount'],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(docs[index]['comment']),
                    ),
                    Divider(
                      height: 2,
                      color: Colors.black54.withOpacity(0.6),
                      thickness: 0.3,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
