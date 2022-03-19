import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/model/subcategory.dart';
import 'package:leco_flutter/screens/login/components/image_data.dart';

class DetailsPage extends StatelessWidget {
  SubCategory? subCategory;

  DetailsPage({this.subCategory});

  Widget _infoCard({String? number, String? title, String? image}) {
    return Expanded(
      child: Column(
        children: [
          Image.asset('assets/images/' + image! + '.png', width: 30),
          Text(
            number!,
            style: const TextStyle(fontSize: 25),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              title!,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCardList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _infoCard(
            number: subCategory!.modelNumber,
            image: 'tag',
            title: '제품명',
          ),
          const SizedBox(
            width: 20,
          ),
          _infoCard(
            number: subCategory!.brick,
            image: 'brick',
            title: '부품수',
          ),
          const SizedBox(
            width: 20,
          ),
          _infoCard(
            number: subCategory!.age,
            image: 'cake',
            title: '연령',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/category/' +
                              subCategory!.imgName! +
                              '.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    child: IconButton(
                      onPressed: Get.back,
                      icon: SvgPicture.asset(
                        'assets/icons/back_arrow.svg',
                        width: 40,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        subCategory!.name!,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: const Color(0xfffffd600),
                              ),
                              onPressed: () {},
                              child: const Text(
                                '공식 홈페이지',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _infoCardList(),
                    Container(
                      child: Text(subCategory!.description!),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          Text(
                            '상품평',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
