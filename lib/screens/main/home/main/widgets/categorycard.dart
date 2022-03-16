import 'package:flutter/material.dart';
import 'package:leco_flutter/model/category.dart';


class CategoryCard extends StatelessWidget {

  Category? category;
  Function()? onCardClick;
  CategoryCard({this.category,this.onCardClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardClick,
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/category/' +
                      category!.imgName! +
                      '.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 120,
                // decoration: BoxDecoration(
                //   borderRadius: const BorderRadius.only(
                //       bottomLeft: Radius.circular(20),
                //       bottomRight: Radius.circular(20)),
                //   gradient: LinearGradient(
                //     begin: Alignment.bottomCenter,
                //     end: Alignment.topCenter,
                //     colors: [
                //       Colors.black.withOpacity(0.7),
                //       Colors.transparent,
                //     ],
                //   ),
                // ),
              ),
            ),
            Positioned(
              top: 0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  category!.name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Jua'
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
