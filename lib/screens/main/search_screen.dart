import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color(0xfffffd600),
            ),
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
                      fontFamily: 'Jua',
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
        elevation: 0,
        backgroundColor: Color(0xfffffd600),
        automaticallyImplyLeading: false,
      ),
      body: Container(),
    );
  }
}
