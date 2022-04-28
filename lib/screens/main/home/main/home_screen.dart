import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/model/category.dart';
import 'package:leco_flutter/model/news.dart';
import 'package:leco_flutter/model/url.dart';
import 'package:leco_flutter/model/utils.dart';
import 'package:leco_flutter/screens/main/home/main/categorylist_screen.dart';
import 'package:leco_flutter/screens/main/home/main/news_screen.dart';
import 'package:leco_flutter/screens/main/home/main/selectedcategory_screen.dart';
import 'package:leco_flutter/screens/main/home/main/widgets/maincategorycard.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TabController tabController;
  List<Category>? categories = Utils.getMockedCategories();

  void _newScreen() {
    Get.to(() => NewsScreen());
  }

  var url = Uri.parse("https://www.toysnbricks.com/");
  List<News> news = [];
  bool isLoading = false;

  Future getData() async {
    setState(() {
      isLoading = true;
    });
    var res = await http.get(url);
    final body = res.body;
    final document = parser.parse(body);
    var response = document
        .getElementsByClassName("posts-loop standard-grid-style")[0]
        .getElementsByClassName("grid-post")
        .forEach((element) {
      setState(() {
        news.add(
          News(
              image: element.children[0].children[0].children[0].children[0]
                  .attributes['src']
                  .toString(),
              subtitle: element.children[0].children[1].text.toString(),
              title:
                  element.children[0].children[1].children[1].text.toString(),
              content:
                  element.children[0].children[2].children[0].text.toString(),
              link: element
                  .children[0].children[0].children[0].attributes['href']
                  .toString()),
        );
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  final TextStyle _style = const TextStyle(
      color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500);

  Widget _menuTab({String? title, Function()? onPressed}) {
    // 메뉴 탭
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title',
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Jua',
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }

  Widget _card({String? thumbPath}) {
    // 제품 카드
    return Column(
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
              child: CachedNetworkImage(
                imageUrl: thumbPath!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '디즈니',
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontSize: 15,
            fontFamily: 'Jua',
          ),
        ),
      ],
    );
  }

  Widget _menuCard() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // physics: const NeverScrollableScrollPhysics(),

        shrinkWrap: true,
        itemCount: categories!.length,
        itemBuilder: (BuildContext context, int index) {
          return MainCategoryCard(
              category: categories![index],
              onCardClick: () {
                Get.to(() => SelectedCategoryScreen(
                      selectedCategory: categories![index],
                    ));
              });
        },
      ),
    );
  }

  Widget _news() {
    // 뉴스
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'LEGO News',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Jua',
                ),
              ),
              TextButton(
                onPressed: _newScreen,
                child: Container(
                  width: 50,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      '더 보기',
                      style: TextStyle(
                        height: 1.5,
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Jua',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        news.length == 0
            ? const SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: 4,
                itemBuilder: (context, index) => _newsCard(index),
              ),
      ],
    );
  }

  Widget _newsCard(index) {
    return GestureDetector(
      onTap: () async{
        await launch(news[index].link);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 6,
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(10),
                  child: Image.network(news[index].image),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                news[index].title,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: _style,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    // 제품 카테고리
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _menuTab(
          title: '카테고리',
          onPressed: () {
            Get.to(() => CategoryListScreen());
          },
        ),
        _menuCard(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '신제품',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Jua',
                ),
              ),
              SizedBox(),
            ],
          ),
        ),
        _homeScreenList(),
      ],
    );
  }

  Widget _homeScreenList() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: Column(
            children: [
              CarouselSlider.builder(
                itemCount: urlImages2.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = urlImages2[index];
                  return buildImage(urlImage.imageUrl!,urlImage.url!,  index);
                },
                options: CarouselOptions(
                  height: 200,
                  // viewportFraction: 1,
                  // autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  autoPlayInterval: const Duration(seconds: 5),
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index),
                ),
              ),
              SizedBox(
                height: 20,
                child: buildIndicator(),
              )
            ],
          ),
        ),
      ],
    );
  }

  int activeIndex = 0;

  final List<Url> urlImages2 = [
    Url(imageUrl: 'https://www.lego.com/cdn/cs/set/assets/blt054743e11f8ee2d1/75329.png?fit=bounds&format=webply&quality=80&width=320&height=320&dpr=1',url: 'https://www.lego.com/ko-kr/product/death-star-trench-run-diorama-75329'),
    Url(imageUrl: 'https://www.lego.com/cdn/cs/set/assets/bltb94f536295aefebf/75330.png?fit=bounds&format=webply&quality=80&width=320&height=320&dpr=1',url: 'https://www.lego.com/ko-kr/product/dagobah-jedi-training-diorama-75330'),
    Url(imageUrl: 'https://www.lego.com/cdn/cs/set/assets/blt86423e4ec25d4312/10276.jpg?fit=bounds&format=webply&quality=80&width=320&height=320&dpr=1',url: 'https://www.lego.com/ko-kr/product/colosseum-10276'),
    Url(imageUrl: 'https://www.lego.com/cdn/cs/set/assets/blte226ac95a59d6b48/10299.png?fit=bounds&format=webply&quality=80&width=320&height=320&dpr=1',url: 'https://www.lego.com/ko-kr/product/real-madrid-santiago-bernabeu-stadium-10299'),
  ];

  Widget buildImage(String urlImage,String url, int index) => InkWell(
    onTap: () async{
      launch(url);
    },
    child: Container(
          color: Colors.white,
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
  );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages2.length,
        effect: const JumpingDotEffect(
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: Colors.blue,
        ),
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfffffd600),
        automaticallyImplyLeading: false,
        title: const Text(
          'LECO',
          style: TextStyle(
            fontFamily: 'Jua',
            fontSize: 35,
            fontWeight: FontWeight.w700,
          ),
        ),
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 10.0),
        //     child: Icon(Icons.settings),
        //   ),
        // ],
        // bottom: _tabMenu(),
      ),
      body: ListView(
        children: [
          _body(),
          _news(),
        ],
      ),
    );
  }
}
