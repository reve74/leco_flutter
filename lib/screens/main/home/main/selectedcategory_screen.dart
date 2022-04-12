import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/model/category.dart';
import 'package:leco_flutter/screens/main/home/main/detailspage.dart';

class SelectedCategoryScreen extends StatelessWidget {
  SelectedCategoryScreen({Key? key, this.selectedCategory}) : super(key: key);
  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xfffffd600),
        title: Text(
          selectedCategory!.name!,
          style: const TextStyle(
            fontFamily: 'Jua',
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.symmetric(vertical: 10),
              crossAxisCount: 2,
              children: List.generate(
                selectedCategory!.subCategories!.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => DetailsPage(subCategory: selectedCategory!.subCategories![index]));
                    },
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/category/' +
                                selectedCategory!.subCategories![index].imgName! +
                                '.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          selectedCategory!.subCategories![index].name!,
                          style: const TextStyle(
                            fontFamily: 'Jua',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
