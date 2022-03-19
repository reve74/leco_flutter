import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:leco_flutter/model/subcategory.dart';

class Category {
  String? name;
  String? imgName;
  String? description;
  List<SubCategory>? subCategories;
  // String? url;

  Category({this.name, this.imgName, this.subCategories, this.description});

  // factory Category.fromJson(Map<String, dynamic> json) {
  //   return Category(
  //       name: json['name'],
  //       imgName: json['imgName'],
  //       subCategories: SubCategory.fromJsonArray(json['subCategories']));
  // }
}
