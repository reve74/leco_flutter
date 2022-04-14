import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leco_flutter/controller/post_controller.dart';
import 'package:leco_flutter/controller/upload_controller.dart';
import 'package:leco_flutter/screens/main/components/review_card.dart';
import 'package:leco_flutter/screens/main/home/create/upload_screen.dart';

class ReviewScreen extends StatefulWidget {
  ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  PostController postController = Get.put(PostController());

  final dbRef = FirebaseDatabase.instance.reference().child('posts');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(UploadScreen(), binding: BindingsBuilder(() {
            Get.put(UploadController());
          }));
        },
        backgroundColor: Color(0xfffffd600),
        child: Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              '리뷰 페이지',
              style: TextStyle(
                fontFamily: 'Jua',
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            floating: true,
            // flexibleSpace: Placeholder(),
            expandedHeight: 50,
            backgroundColor: Color(0xfffffd600),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: [
                  // Expanded(
                  //     child: FirebaseAnimatedList(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   shrinkWrap: false,
                  //   query: dbRef.child('Pst List'),
                  //   itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  //       Animation<double> animation, int index) {
                  //     return Column(
                  //       children: [
                  //         FadeInImage.assetNetwork(
                  //             placeholder: 'assets/images/spiderman.png',
                  //             image: snapshot.value['image'])
                  //       ],
                  //     );
                  //   },
                  // ))

                  ...List.generate(
                    1,
                    (index) => ReviewCard(
                      number: index,
                    ),
                  ).toList(),
                ],
              );
            }, childCount: 1),
          ),
        ],
      ),
      // SingleChildScrollView(
      //   child: Column(
      //     children: List.generate(
      //       20,
      //       (index) => ReviewCard(
      //         number: index,
      //       ),
      //     ).toList(),
      //   ),
      // ),
    );
  }
}
