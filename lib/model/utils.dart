import 'package:leco_flutter/model/category.dart';
import 'package:leco_flutter/model/subcategory.dart';

class Utils {
  static List<Category> getMockedCategories() {
    return [
      Category(
        name: 'Creator Expert',
        imgName: 'creatorexpert',
        subCategories: [
          SubCategory(
            name: '레고® 베스파 125',
            imgName: 'vespa',
          ),
          SubCategory(
              name: '부티크 호텔',
              imgName: 'boutique',
          ),
          SubCategory(
              name: '캄 노우 – FC 바르셀로나',
              imgName: 'campnou'
          ),
          SubCategory(
              name: '디스커버리 우주왕복선',
              imgName: 'discovery'
          ),
          SubCategory(
              name: '레고® 타이타닉',
              imgName: 'titanic'
          ),

        ]
      ),
      Category(
          name: 'Disney',
          imgName: 'disney',
          subCategories: []

      ),
      Category(
          name: 'Marvel',
          imgName: 'marvel',
          subCategories: []
      ),
      Category(
          name: 'Starwars',
          imgName: 'starwars',
          subCategories: []
      ),
      Category(
          name: 'Architecture',
          imgName: 'architecture',
          subCategories: []
      ),
      Category(
          name: 'Minifigure',
          imgName: 'minifigure',
          subCategories: []
      ),
    ];
  }
}