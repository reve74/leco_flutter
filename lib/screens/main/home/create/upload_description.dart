import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/upload_controller.dart';
import 'package:leco_flutter/screens/main/components/image_data.dart';

class UploadDescription extends GetView<UploadController> {
  const UploadDescription({Key? key}) : super(key: key);

  Widget _description(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .3,
              child: Image.file(
                controller.filteredImage!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            maxLines: 1,
            controller: controller.title,
            decoration: const InputDecoration(
              hintText: '글 제목',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.amber,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.amber),
              ),
              border: OutlineInputBorder(),
              hintStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
              labelStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            maxLines: null,
            controller: controller.content,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              hintText: '글 내용',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.amber,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.amber),
              ),
              border: OutlineInputBorder(),
              hintStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
              labelStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(
              IconsPath.backBtnIcon,
              width: 50,
            ),
          ),
        ),
        title: const Text(
          '새 게시물',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: controller.uploadPost,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ImageData(
                IconsPath.uploadComplete,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: controller.unfocusKeyboard,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _description(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
