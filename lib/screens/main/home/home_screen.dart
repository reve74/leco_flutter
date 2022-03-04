import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    // tabController = TabController(length: 4, vsync: this);
  }

  Widget _menuTab({String? title, Function()? onPressed}) { // 메뉴 탭
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

  Widget _card({String? thumbPath, double? size}) { // 제품 카드
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
            borderRadius: BorderRadius.circular(size!),
            child: SizedBox(
              width: size,
              height: size,
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            10,
            (index) => _card(
              size: 100,
              thumbPath:
                  'https://www.lego.com/cdn/cs/set/assets/bltfb7085baebd9e2ca/ThemeImage-202107-Disney.jpg?fit=bounds&format=webply&quality=80&width=420&height=200&dpr=1',
            ),
          ),
        ],
      ),
    );
  }

  Widget _news() { // 뉴스
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
        _newsCard(),
      ],
    );
  }

  Widget _newsCard() { // 뉴스 카드
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

  Widget _body() { // 제품 카테고리
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _menuTab(
          title: '카테고리',
          onPressed: () {},
        ),
        _menuCard(),
        _menuTab(
          title: '신제품',
          onPressed: () {},
        ),
        _menuCard(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfffffd600),
        automaticallyImplyLeading: false,
        // centerTitle: true,
        // leading: Container(),
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
