import 'package:flutter/material.dart';
import 'package:leco_flutter/model/category.dart';

class CategoryScreen extends StatelessWidget {
  Category? selectedCategory;

  CategoryScreen({this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfffffd600),
        title: Text(
          selectedCategory!.name!,
          style: TextStyle(
            fontFamily: 'Jua',
            fontSize: 25,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                  this.selectedCategory!.subCategories!.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {

                      },
                      child: Column(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/category/new/' +
                                  selectedCategory!.subCategories![index].imgName!+'.png',
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            selectedCategory!.subCategories![index].name!,
                            style: const TextStyle(fontFamily: 'Jua'),
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
      ),
    );
  }
}
