import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/screens/main/components/review_card.dart';
import 'package:leco_flutter/screens/main/home/create/write_screen.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(WriteScreen());
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
                color: Colors.black54,
              ),
            ),
            floating: true,
            // flexibleSpace: Placeholder(),
            expandedHeight: 50,
            backgroundColor: Color(0xfffffd600),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                children: [
                  ...List.generate(
                    20,
                    (index) => ReviewCard(
                      number: index,
                    ),
                  ).toList(),
                ],
              ),
            ),
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
