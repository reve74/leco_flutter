import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/auth_controller.dart';
import 'package:leco_flutter/controller/product_comment_controller.dart';
import 'package:leco_flutter/model/productcomment.dart';
import 'package:leco_flutter/model/subcategory.dart';
import 'package:leco_flutter/settings/firebase.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  SubCategory? subCategory;

  DetailsPage({this.subCategory});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double rating = 0;
  final _comment = TextEditingController();

  AuthController a = Get.put(AuthController());
  ProductCommentController productCommentController =
  Get.put(ProductCommentController());

  Widget _infoCard({String? number, String? title, String? image}) {
    return Expanded(
      child: Column(
        children: [
          Image.asset('assets/images/' + image! + '.png', width: 30),
          Text(
            number!,
            style: const TextStyle(fontSize: 25),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              title!,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCardList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _infoCard(
            number: widget.subCategory!.modelNumber,
            image: 'tag',
            title: '제품명',
          ),
          const SizedBox(
            width: 20,
          ),
          _infoCard(
            number: widget.subCategory!.brick,
            image: 'brick',
            title: '부품수',
          ),
          const SizedBox(
            width: 20,
          ),
          _infoCard(
            number: widget.subCategory!.age,
            image: 'cake',
            title: '연령',
          ),
        ],
      ),
    );
  }

  Widget ratingBar({double rating = 0}) {
    return RatingBar.builder(
      updateOnDrag: true,
      itemBuilder: (context, _) =>
      const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) =>
          setState(
                () {
              this.rating = rating;
              print(rating);
              setState(() {});
            },
          ),
    );
  }

  Future<List<QueryDocumentSnapshot<ProductComment>>> findAll() async =>
      await firebaseFirestore
          .collection('productComments')
          .doc(widget.subCategory!.modelNumber!)
          .collection('comments')
          .withConverter<ProductComment>(
          fromFirestore: ((snapshot, options) =>
              ProductComment.fromJson(snapshot.data()!)),
          toFirestore: (productComment, options) => productComment.toJson())
          .get()
          .then((snapshot) => snapshot.docs);

  @override
  Widget build(BuildContext context) {
    findAll();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/category/' +
                              widget.subCategory!.imgName! +
                              '.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    child: IconButton(
                      onPressed: Get.back,
                      icon: SvgPicture.asset(
                        'assets/icons/back_arrow.svg',
                        width: 40,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        widget.subCategory!.name!,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: const Color(0xfffffd600),
                              ),
                              onPressed: () async {
                                await launch(widget.subCategory!.url!,
                                    forceWebView: false, forceSafariVC: false);
                              },
                              child: const Text(
                                '공식 홈페이지',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              // Get.to(() => Stars());
                            },
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _infoCardList(),
                    Container(
                      child: Text(widget.subCategory!.description!),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          '상품평',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RatingBar.builder(
                              updateOnDrag: true,
                              itemBuilder: (context, _) =>
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) =>
                                  setState(() {
                                    this.rating = rating;
                                  }),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _comment,
                                    decoration: const InputDecoration(
                                      hintText: ('제품을 평가해주세요!'),
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blueAccent),
                                  onPressed: () {
                                    productCommentController.insert(
                                      username: a.firestoreUser.value.username!,
                                      uid: auth.currentUser!.uid,
                                      starCount: rating,
                                      comment: _comment.text.trim(),
                                      user: AuthController.to.firestoreUser(),
                                      modelNumber:
                                      widget.subCategory!.modelNumber!,
                                    );
                                    setState(() {
                                      _comment.text = '';
                                    });
                                  },
                                  child: Text('등록'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        StreamBuilder(
                          stream: firebaseFirestore
                              .collection('productComments')
                              .doc(widget.subCategory!.modelNumber!)
                              .collection('comments')
                              .orderBy('created', descending: false)
                              .snapshots(),
                          builder: (context, snapshot) {
                            // if (!snapshot.hasData == false) {
                            //   return Container();
                            // }else if(snapshot.hasError) {
                            //   return Container();
                            // }
                            final docs = (snapshot.data! as dynamic).docs;
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: docs.length,
                              itemBuilder: (context, index) =>
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children: [
                                        //TODO: dateformating 필요
                                        // Text(DateFormat.yMMMd().format(docs[index]['created'])),
                                        Row(
                                          children: [
                                            Text(docs[index]['created']
                                                .toDate()
                                                .toString()),
                                            const Spacer(),
                                            TextButton(
                                              onPressed: () {
                                                productCommentController.delete(
                                                    modelNumber: widget
                                                        .subCategory!
                                                        .modelNumber!,
                                                    uid: auth.currentUser!.uid);
                                              },
                                              child: Text('삭제'),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Text(docs[index]['username']),
                                        ),
                                        RatingBarIndicator(
                                          itemBuilder: (context, _) =>
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          rating: docs[index]['starCount'],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Text(docs[index]['comment']),
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Colors.black54.withOpacity(
                                              0.6),
                                          thickness: 0.3,
                                        ),
                                      ],
                                    ),
                                  ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
