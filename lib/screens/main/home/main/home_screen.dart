import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/model/category.dart';
import 'package:leco_flutter/model/utils.dart';
import 'package:leco_flutter/screens/main/home/main/categorylist_screen.dart';
import 'package:leco_flutter/screens/main/home/main/selectedcategory_screen.dart';
import 'package:leco_flutter/screens/main/home/main/widgets/maincategorycard.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TabController tabController;
  List<Category>? categories = Utils.getMockedCategories();

  var title = <String?>[];
  var post = <String?>[];
  var link = <String?>[];
  var image = <String?>[];

  void _getDataFromWeb() async {
    final response = await http
        .get(Uri.parse('https://www.lego.com/en-us/aboutus/newsroom/'));
    dom.Document document = parser.parse(response.body);

    final link2 = document.getElementsByClassName('entry-title');

    final content = document.getElementsByClassName(
        'post-32884 post type-post status-publish format-standard has-post-thumbnail category-news tag-3674 tag-75341-luke-skywalkers-landspeeder tag-cesar-carvalhosa-soares tag-landspeeder tag-lego-star-wars tag-may-2022 tag-may-the-4th tag-star-wars tag-ucs tag-ultimate-collectors-series entry gfwa-1 gfwa-odd');
    final elements =
        document.getElementsByClassName('entry-header blog-entry-header');
    final imageElement = document.getElementsByClassName(
        'post-32884 post type-post status-publish format-standard has-post-thumbnail category-news tag-3674 tag-75341-luke-skywalkers-landspeeder tag-cesar-carvalhosa-soares tag-landspeeder tag-lego-star-wars tag-may-2022 tag-may-the-4th tag-star-wars tag-ucs tag-ultimate-collectors-series entry gfwa-1 gfwa-odd');

    setState(() {
      title = elements
          .map((e) => e.getElementsByTagName("a")[0].innerHtml)
          .toList();

      post =
          content.map((e) => e.getElementsByTagName("a")[0].innerHtml).toList();

      link = link2
          .map((e) => e.getElementsByTagName("a")[0].attributes['href'])
          .toList(); // href 링크

      image = imageElement
          .map((e) => e
              .getElementsByTagName("img")[0]
              .attributes['jetpack-lazy-image jetpack-lazy-image--handled'])
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataFromWeb();
    // print(post.length);
  }

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
                onPressed: () {},
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
        post.length == 0
            ? const Text(
                'No data',
                style: TextStyle(color: Colors.black),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: post.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () async {},
                          child: Card(
                            child: Container(
                              color: Colors.black,
                              child: Column(
                                children: [
                                  Container(
                                    child: Image.network(
                                      image[index]!,
                                      scale: 0.1,
                                    ),
                                  ),
                                  // Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: Text(
                                  //     title[index]!,
                                  //     style: TextStyle(
                                  //       color: Colors.red,
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(height: 15),
                                  Text(
                                    post[index]!,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  // ElevatedButton(
                                  //   onPressed: () async {
                                  //     dynamic url = link[index];
                                  //     if (await canLaunch(url)) {
                                  //       launch(url);
                                  //       print(launch);
                                  //     } else {
                                  //       print('error');
                                  //     }
                                  //   },
                                  //   child: Text('View in website'),
                                  //   style: ElevatedButton.styleFrom(),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
        // _newsCard(),
      ],
    );
  }

  Widget _newsCard() {
    // 뉴스 카드
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                width: 170,
                height: 120,
                color: Colors.grey.withOpacity(0.5),
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'The LEGO Foundation has announced it will donate 600 LEGO® MRI Scanners to hospitals worldwide to help children',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // 글자 넘어갈때 '...'처리 해주는 속성
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                width: 170,
                height: 120,
                color: Colors.grey.withOpacity(0.5),
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'An Italian Style Icon: An Italian Style Icon: The elegance of the 1960’s with the new LEGO® Vespa 125',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // 글자 넘어갈때 '...'처리 해주는 속성
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
        _menuTab(
          title: '신제품',
          onPressed: () {
            // Get.to(() => CategoryScreen(
            //       selectedCategory: Utils.getMockedCategories()[0],
            //     ));
          },
        ),
        _menuCard(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print(post.length);
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.settings),
          ),
        ],
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
