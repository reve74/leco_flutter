import 'package:leco_flutter/model/category.dart';
import 'package:leco_flutter/model/subcategory.dart';

class Utils {
  static List<Category> getMockedCategories() {
    return [
      Category(
        name: 'Creater',
        imgName: 'Creater',
        subCategories: [
          SubCategory(
            name: '레고® 베스파 125',
            imgName: 'vespa'
          ),
          SubCategory(
              name: '부티크 호텔',
              imgName: 'boutique'
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
              name: '프렌즈 아파트',
              imgName: 'friends'
          ),

        ]
      ),
      Category(
          name: 'Harrypotter',
          imgName: 'Harrypotter',
          subCategories: []
      ),
      Category(
          name: 'Disney',
          imgName: 'Disney',
          subCategories: []
      ),
      Category(
          name: 'Starwars',
          imgName: 'Starwars',
          subCategories: []
      ),
    ];
  }
}