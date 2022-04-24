import 'package:flutter/material.dart';
import 'package:leco_flutter/model/subcategory.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<SubCategory> _model = [
    SubCategory(name: '레고® 베스파 125', imgName: 'vespa', modelNumber: '10298'),
    SubCategory(name: '부티크 호텔', imgName: 'boutique', modelNumber: '10297'),
    SubCategory(
        name: '캄 노우 – FC 바르셀로나', imgName: 'campnou', modelNumber: '10284'),
    SubCategory(
        name: '디스커버리 우주왕복선', imgName: 'discovery', modelNumber: '10283'),
    SubCategory(name: '레고® 타이타닉', imgName: 'titanic', modelNumber: '10294'),
    SubCategory(
        name: '미키와 미니의 우주 로켓', imgName: 'mickey_rocket', modelNumber: '10774'),
    SubCategory(name: '미키의 비행기', imgName: 'mickey_plane', modelNumber: '10772'),
    SubCategory(
        name: '디즈니 미키 마우스와 미니 마우스', imgName: 'mickey_minnie', modelNumber: '43179'),
    SubCategory(name: '디즈니 캐슬', imgName: 'disney_castle', modelNumber: '71040'),
    SubCategory(name: '곰돌이 푸', imgName: 'pooh', modelNumber: '21326'),
  ];

  List<SubCategory> _foundedModel = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      _foundedModel = _model;
    });
  }

  onSearch(String search) {
    setState(() {
      _foundedModel = _model
          .where((subCategory) => subCategory.modelNumber!.contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 38,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(0),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: '제품번호 검색',
              hintStyle: const TextStyle(
                color: Colors.black,
                // fontFamily: 'Jua',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              // enabledBorder: InputBorder.none,
              // focusedBorder: InputBorder.none,
            ),
            onChanged: (value) {
              onSearch(value);
            },
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xfffffd600),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: _foundedModel.length,
          itemBuilder: (context, index) {
            return productComponent(subCategory: _foundedModel[index]);
          },
        ),
      ),
    );
  }

  Widget productComponent({required SubCategory subCategory}) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                  'assets/subcategory/' + subCategory.imgName! + '.jpeg'),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subCategory.modelNumber!),
              const SizedBox(height: 5),
              Text(
                subCategory.name!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }
}
