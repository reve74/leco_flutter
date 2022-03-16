import 'package:flutter/material.dart';
import 'package:leco_flutter/model/category.dart';

class MainCategoryCard extends StatelessWidget {
  Category? category;
  Function()? onCardClick;

  MainCategoryCard({this.category, this.onCardClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onCardClick!(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  'assets/category/' + category!.imgName! + '.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            category!.name!,
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 15,
              fontFamily: 'Jua',
            ),
          ),
        ],
      ),
    );
  }
}
