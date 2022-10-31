import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fym/bar/WebViewBarArticles.dart';
import 'package:fym/bar/navBar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyArticlesReader extends StatefulWidget {
  final String articleURL;

  MyArticlesReader({required this.articleURL});
  @override
  _MyArticlesReaderState createState() =>
      _MyArticlesReaderState(articleUrl: '${this.articleURL}');
}

class _MyArticlesReaderState extends State<MyArticlesReader> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }

  final String articleUrl;
  _MyArticlesReaderState({required this.articleUrl});
  Widget build(BuildContext) {
    return Scaffold(
      appBar: WebViewTopBar(
        articleURL: "${this.articleUrl}",
      ),
      bottomNavigationBar: navBar(),
      body: WebView(
        initialUrl: "${this.articleUrl}",
      ),
    );
  }
}
