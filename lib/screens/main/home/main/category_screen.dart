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
        title: const Text(
          '카테고리',
          style: TextStyle(
            fontFamily: 'Jua',
            fontSize: 25,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text(this.selectedCategory!.name!),
        ),
      ),
    );
  }
}
