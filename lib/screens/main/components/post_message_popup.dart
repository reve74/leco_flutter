import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostMessagePopUp extends StatelessWidget {
  final String? title;
  final String? message;
  final Function()? okCallback;

  const PostMessagePopUp(
      {Key? key,
      required this.title,
      required this.message,
      required this.okCallback,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: Get.width * 0.6,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                children: [
                  Text(
                    title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 7,),
                  Text(
                    message!,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: okCallback, // (){okCallback();} => 키 안먹음
                    child: const Text('확인'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
