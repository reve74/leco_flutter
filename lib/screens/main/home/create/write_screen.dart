import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WriteScreen extends StatefulWidget {
  WriteScreen({Key? key}) : super(key: key);

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  String postTitle = "";
  String postContent = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: title,
              onChanged: (value) {
                setState(() {
                  postTitle = value;
                });
              },
              decoration: const InputDecoration(
                hintText: '제목',
              ),
            ),
            TextField(
              controller: content,
              onChanged: (value) {
                setState(() {
                  postContent = value;
                });
              },
              decoration: const InputDecoration(
                hintText: '내용',
              ),
            ),
            ElevatedButton(
              onPressed: () async{
                try{
                  await FirebaseFirestore.instance.collection('posts').doc().set({
                    'postTitle' : postTitle,
                    'postContent' : postContent,
                  });
                }on FirebaseFirestore catch(e) {
                  print(e.toString());
                }
              },
              child: Text('등록'),
            ),
          ],
        ),
      ),
    );
  }
}
