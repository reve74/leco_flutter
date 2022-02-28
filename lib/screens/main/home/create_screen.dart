import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/screens/main/home/create/detail_screen.dart';

import 'create/write_screen.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(WriteScreen());
        },
        elevation: 0,
        backgroundColor: const Color(0xfffffd600),
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text('1'),
            onTap: () {
              Get.to(DetailScreen());
            },
            title: Text('제목'),
          );
        },
      ),
    );
  }
}
