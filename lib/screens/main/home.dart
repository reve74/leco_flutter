import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leco_flutter/screens/main/components/homescreen_top.dart';
import 'package:leco_flutter/screens/main/components/review_card.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeScreenTop(
          ),
          Column(
            children: List.generate(
              20,
              (index) => ReviewCard(
                number: index,
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }
}
