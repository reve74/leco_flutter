import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/model/productcomment.dart';
import 'package:leco_flutter/model/user.dart';
import 'package:leco_flutter/settings/firebase.dart';

class ProductCommentController extends GetxController {
  static ProductCommentController get to => Get.find();

  final pc = <ProductComment>[].obs;

  final productCommentRef = firebaseFirestore
      .collection("productComments")
      .withConverter<ProductComment>(
        fromFirestore: (snapshot, options) =>
            ProductComment.fromJson(snapshot.data()!),
        toFirestore: (pc, options) => pc.toJson(),
      );

  Future<void> insert(
      {required String comment,
      required UserModel user,
      // required double starCount,
      required String modelNumber}) async {
    ProductComment pc = ProductComment(
      comment: comment,
      modelNumber: modelNumber,
      user: user,
      created: DateTime.now(),
      // starCount: starCount,
    );
    await firebaseFirestore
        .collection("productComments")
        .doc(modelNumber)
        .collection("comments")
        .withConverter<ProductComment>(
          fromFirestore: (snapshot, options) =>
              ProductComment.fromJson(snapshot.data()!),
          toFirestore: (pc, options) => pc.toJson(),
        )
        .add(pc);
  }

  Future<List<QueryDocumentSnapshot<ProductComment>>> findAll() async =>
      await productCommentRef.get().then((snapshot) => snapshot.docs);
}
