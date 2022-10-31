import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fym/bar/navBar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyAboutPage extends StatefulWidget {
  @override
  _MyAboutPageState createState() => _MyAboutPageState();
}

class _MyAboutPageState extends State<MyAboutPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navBar(),
      body: WebView(
        initialUrl: "https://github.com/Cat-Man123/",
      ),
    );
  }
}
