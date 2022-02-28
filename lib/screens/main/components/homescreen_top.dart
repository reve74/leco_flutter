import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leco_flutter/screens/main/components/review_card.dart';

class HomeScreenTop extends StatefulWidget {
  HomeScreenTop({Key? key}) : super(key: key);

  @override
  State<HomeScreenTop> createState() => _HomeScreenTopState();
}

class _HomeScreenTopState extends State<HomeScreenTop> with TickerProviderStateMixin{

  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  Widget _body() {
    return TabBarView(
      controller: tabController,
      children: [
        // Column(
        //   children: List.generate(
        //     20,
        //         (index) => ReviewCard(
        //       number: index,
        //     ),
        //   ).toList(),
        // ),
        Center(
          child: Text('인기 페이지'),
        ),
        Center(
          child: Text('인기 페이지'),
        ),
        Center(
          child: Text('계정 페이지'),
        ),
        Center(
          child: Text('오디오 페이지'),
        ),
      ],
    );
  }


  Widget _tabMenuOne(String menu, Color color) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(color: Colors.white, width: 0.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          child: Text(
            menu,
            style: const TextStyle(
                fontSize: 14, fontFamily: 'Hi', fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _brick() {
    // 탭 위젯
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.8),
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            indicatorColor: Colors.black,
            tabs: [
              _tabMenuOne('리뷰게시판', Colors.red),
              _tabMenuOne('창작게시판', Colors.blue),
              _tabMenuOne('발매소식', Colors.orange),
              _tabMenuOne('공지사항', Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                // height: height * 0.8,
                height: height * 0.4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/main_background_img.png'),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 40,
                        bottom: 10,
                        left: 5,
                        right: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add_alert),
                            iconSize: 30,
                          ),
                          const Text(
                            'LECO',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.settings),
                            iconSize: 30,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 50,
                            color: Colors.red.withOpacity(0.23),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/search.svg',
                            color: Colors.black,
                            width: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: '검색',
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontFamily: 'Hi',
                                  fontSize: 20,
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    _brick(),
                    _body(),
                  ],
                ),
              ),
            ],
          ), // _body(),
        ],
      ),

    );
  }
}
