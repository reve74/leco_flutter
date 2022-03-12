import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:leco_flutter/model/subcategory.dart';

class Category {
  String? name;
  String? imgName;

  Category({this.name, this.imgName});

  // factory Category.fromJson(Map<String, dynamic> json) {
  //   return Category(
  //       name: json['name'],
  //       imgName: json['imgName'],
  //       subCategories: SubCategory.fromJsonArray(json['subCategories']));
  // }
}
