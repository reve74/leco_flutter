import 'package:flutter/material.dart';
import 'package:leco_flutter/screens/main/components/review_card.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: List.generate(
            20,
                (index) => ReviewCard(
              number: index,
            ),
          ).toList(),
        ),
      ),
    );
  }
}
