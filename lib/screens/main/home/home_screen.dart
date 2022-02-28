import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leco_flutter/screens/main/home/create_screen.dart';
import '../components/review_card.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
        SingleChildScrollView(
          child: Column(
            children: List.generate(
              20,
              (index) => ReviewCard(
                number: index,
              ),
            ).toList(),
          ),
        ),
        // Center(
        //   child: Text('인기 페이지'),
        // ),
        CreateScreen(),
        Center(
          child: Text('발매소식'),
        ),
        Center(
          child: Text('공지사항'),
        ),
      ],
    );
  }

  Widget _tabMenuOne({String? menu, Color? color}) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5, top: 5),
          height: 40,
          width: 40,
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
              height: 15,
              width: 15,
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
            menu!,
            style: const TextStyle(
                fontSize: 13,
                // fontFamily: 'Hi',
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _tabMenu() {
    return PreferredSize(
      child: Container(
        height: 70,
        width: Size.infinite.width,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xffe4e4e4))),
        ),
        child: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          tabs: [
            _tabMenuOne(menu: '리뷰게시판', color: Colors.red),
            _tabMenuOne(menu: '창작게시판', color: Colors.yellow),
            _tabMenuOne(menu: '발매소식', color: Colors.green),
            _tabMenuOne(menu: '공지사항', color: Colors.blue),
          ],
        ),
      ),
      preferredSize: Size.fromHeight(70),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfffffd600),
        leading: Icon(Icons.add_alert),
        centerTitle: true,
        title: const Text(
          'LECO',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(Icons.settings),
          ),
        ],
        bottom: _tabMenu(),
      ),
      body: _body(),
    );
  }
}
