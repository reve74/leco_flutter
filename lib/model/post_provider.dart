import 'package:cloud_firestore/cloud_firestore.dart';


class PostProvider {
  Future<QuerySnapshot> findAll() => FirebaseFirestore.instance
      .collection('posts')
      .orderBy("created", descending: true)
      .get();


}