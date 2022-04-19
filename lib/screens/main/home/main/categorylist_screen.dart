import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/product_comment_controller.dart';
import 'package:leco_flutter/model/category.dart';
import 'package:leco_flutter/model/utils.dart';
import 'package:leco_flutter/screens/main/home/main/selectedcategory_screen.dart';
import 'package:leco_flutter/screens/main/home/main/widgets/categorycard.dart';

class CategoryListScreen extends StatelessWidget {
  List<Category>? categories = Utils.getMockedCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xfffffd600),
        title: const Text(
          '카테고리',
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontFamily: 'Jua',
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // const Padding(
          //   padding: EdgeInsets.symmetric(vertical: 8.0),
          //   child: Text(
          //     '카테고리를 선택하세요',
          //     style: TextStyle(
          //       fontFamily: 'JUA',
          //       color: Colors.black,
          //       fontSize: 20,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: categories!.length,
              itemBuilder: (BuildContext context, int index) {
                return CategoryCard(
                  onCardClick: () {
                    Get.to(
                        () => SelectedCategoryScreen(
                              selectedCategory: categories![index],
                            ), binding: BindingsBuilder(() {
                      Get.put(ProductCommentController());
                    }));
                  },
                  category: categories![index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
