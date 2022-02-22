import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreenTop extends StatelessWidget {
  const HomeScreenTop({Key? key}) : super(key: key);

  Widget brick({Color? color, String? tab}) {
    // 탭 위젯
    return GestureDetector(
      onTap: () {},
      child: Column(
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
          Text(
            tab!,
            style: const TextStyle(
                fontSize: 15, fontFamily: 'Hi', fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Stack(
      children: [
        Container(
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
                  bottom: 20,
                  left: 5,
                  right: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                      },
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
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: EdgeInsets.symmetric(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  brick(color: Colors.red, tab: '리뷰게시판'),
                  brick(color: Colors.orange, tab: '창작게시판'),
                  brick(color: Colors.blue, tab: '발매소식'),
                  brick(color: Colors.green, tab: '공지사항'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
