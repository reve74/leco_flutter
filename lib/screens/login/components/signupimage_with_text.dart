import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupImagewithText extends StatelessWidget {
  SignupImagewithText({Key? key, required this.title, this.color}) : super(key: key);

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: height * 0.4,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Image.asset(
                  'assets/images/login_img.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: height * 0.07,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child:  Text(
            '$title',
            style: TextStyle(
              fontFamily: 'Jua',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
