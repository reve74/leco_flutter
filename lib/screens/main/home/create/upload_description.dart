import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/upload_controller.dart';
import 'package:leco_flutter/screens/main/components/image_data.dart';

class UploadDescription extends GetView<UploadController> {
  UploadDescription({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

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
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '제목',
                  style: TextStyle(fontSize: 15),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length < 2) {
                      return '2글자 이상 입력해주세요';
                    }
                    return null;
                  },
                  maxLines: 1,
                  controller: controller.title,
                  decoration: InputDecoration(
                    hintText: '제목을 입력하세요',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.grey.withOpacity(0.6),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Colors.grey.withOpacity(0.6)),
                    ),
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                    labelStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '내용',
                  style: TextStyle(fontSize: 15),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return '5글자 이상 입력해주세요';
                    }
                    return null;
                  },
                  maxLines: null,
                  controller: controller.content,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                    hintText: '내용을 입력하세요',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.grey.withOpacity(0.6),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Colors.grey.withOpacity(0.6)),
                    ),
                    border: const OutlineInputBorder(),
                    hintStyle: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                    labelStyle: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
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
            onTap: () {
              if (_formKey.currentState!.validate()) {
                controller.uploadPost();
              }
            },
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
