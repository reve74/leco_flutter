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
              description:
                  '성인을 위한 레고® 베스파 125 모델 키트를 통해 특별한 마음챙김 조립 프로젝트의 세계에 빠져보아요. \n'
                  '1960년대의 클래식 베스파 피아지오 모델이 파스텔 블루 색상으로 다시 돌아왔어요. 매우 희귀한 색상이라 레고 조립 팬이라면 누구나 구미가 당길 걸요. 베스파 75주년을 기념하여 탄생한 이 세트는 레고 디자이너 팀과 베스파의 긴밀한 협업을 통해 개발되었으며, 특히 성인 조립 애호가를 대상으로 놀랍도록 멋진 모델만큼이나 몰입적인 조립 체험을 약속합니다.\n'
              // '아름다운 디테일과 사실적인 기능\n'
              // '이 베스파 조립 모델은 외발 서스펜션 전륜, 2개의 시트, 착탈식 엔진 커버, 브릭 조립식 엔진, 실제 작동하는 킥스탠드와 핸들 등의 구성품에 더하여 베스파 로고, 클래식한 느낌의 1960년대풍 이탈리아 번호판, 스페어 휠, 헬멧, 바스켓, 뒤편의 꽃다발 등 온갖 액세서리와 소품까지 모든 것이 마치 오리지널 실물을 보는 듯한 느낌을 자아냅니다.\n'
              // '오롯한 나만의 공간이 열립니다\n'
              // '성인을 위해 특별히 디자인된 사실적인 모델을 통해 창의력과 집중력을 연마하며 꿈의 탑승기계 컬렉션을 하나하나 늘려보아요.'
              ,
              modelNumber: '10298',
              brick: '1106',
              age: '18 +',
            ),
            SubCategory(
              name: '부티크 호텔',
              imgName: 'boutique',
              description: '부티크',
              modelNumber: '10298',
              brick: '1106',
              age: '18 +',
            ),
            SubCategory(
              name: '캄 노우 – FC 바르셀로나',
              imgName: 'campnou',
              description: '캄프누',
              modelNumber: '10298',
              brick: '1106',
              age: '18 +',
            ),
            SubCategory(
              name: '디스커버리 우주왕복선',
              imgName: 'discovery',
              description: '디스커버리',
              modelNumber: '10298',
              brick: '1106',
              age: '18 +',
            ),
            SubCategory(
              name: '레고® 타이타닉',
              imgName: 'titanic',
              description: '타이타닉',
              modelNumber: '10298',
              brick: '1106',
              age: '18 +',
            ),
          ]),
      Category(name: 'Disney', imgName: 'disney', subCategories: []),
      Category(name: 'Marvel', imgName: 'marvel', subCategories: []),
      Category(name: 'Starwars', imgName: 'starwars', subCategories: []),
      Category(
          name: 'Architecture', imgName: 'architecture', subCategories: []),
      Category(name: 'Minifigure', imgName: 'minifigure', subCategories: []),
    ];
  }
}
