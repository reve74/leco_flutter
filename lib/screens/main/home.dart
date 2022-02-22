import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leco_flutter/screens/main/components/homescreen_top.dart';

import 'components/post_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Widget _postList() { // 게시물 위젯
    return Column(
      children: List.generate(
        20,
            (index) => PostWidget(),
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeScreenTop(),
          // ListView(
          //   children: [
          //     _postList(),
          //   ],
          // ),
        ],
      ),
    );
  }
}
