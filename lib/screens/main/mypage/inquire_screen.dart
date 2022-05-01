import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InquireScreen extends StatelessWidget {
   InquireScreen({Key? key}) : super(key: key);
   WebViewController? controller;
   final homeUrl = 'https://docs.google.com/forms/u/1/d/e/1FAIpQLSd9ciG3H45HzlzVz097Ls1wvvnkTDHbxic-eKS0AsgmH-f-Xw/viewform?vc=0&c=0&w=1&flr=0&usp=mail_form_link';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
        ),
      ),
      body: WebView(
        onWebViewCreated: (WebViewController controller) {
          this.controller = controller;
        },
        initialUrl: homeUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
