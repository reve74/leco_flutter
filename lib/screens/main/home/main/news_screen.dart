import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:leco_flutter/model/news.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
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

  Widget _newsCard(index) {
    return GestureDetector(
      onTap: () async {
        await launch(
          news[index].link,
          forceWebView: false,
          forceSafariVC: false,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Container(
          width: 160,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 2,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Row(
            children: [
              Image.network(
                news[index].image,
                width: 160,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${news[index].title}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      ' ${news[index].content}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffffd600),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'LEGO NEWS',
          style: TextStyle(
            height: 1.5,
            fontFamily: 'Jua',
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: news.length == 0
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) => _newsCard(index),
            ),
    );
  }
}
