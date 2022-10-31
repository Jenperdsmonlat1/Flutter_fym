import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fym/ArticlesReaderPage.dart';
import 'package:fym/bar/navBar.dart';
import 'package:fym/bar/topBar.dart';
import 'package:fym/http_request_/sendGetArticlesRequest.dart';
import 'package:fym/ui/Color.dart';
import 'package:fym/http_request_/ArticlesModel.dart';

class MyNewsEcoPage extends StatefulWidget {
  @override
  _MyNewsEcoPageState createState() => _MyNewsEcoPageState();
}

class _MyNewsEcoPageState extends State<MyNewsEcoPage> {
  Widget listArticles(List<Articles>? articles) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (context, position) {
        return Container(
          margin: const EdgeInsets.fromLTRB(25, 20, 25, 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(articles![position].urlToImage),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  articles[position].title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyArticlesReader(
                                  articleURL: articles[position].url)),
                        );
                      },
                      icon: const Icon(
                        Icons.web,
                        color: Colors.black,
                      ),
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                        width: 1.0,
                        color: Colors.black,
                      )),
                      label: const Text(
                        "Lire l'article",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Noto Sans MS",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: background,
      appBar: PreferredSize(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: TopBar(),
          ),
        ),
        preferredSize: const Size(
          double.infinity,
          50,
        ),
      ),
      bottomNavigationBar: navBar(),
      body: FutureBuilder<List<Articles>>(
        future: createArticles(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listArticles(snapshot.data);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Une erreur est survenue. Laquelle ?\n${snapshot.error}",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }
}
