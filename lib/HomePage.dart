import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fym/StatsPage.dart';
import 'package:fym/bar/navBar.dart';
import 'package:fym/bar/topBar.dart';
import 'package:fym/http_request_/CryptoModel.dart';
import 'package:fym/ui/Color.dart';
import 'package:fym/http_request_/sendGetRequestCrypto.dart';
import 'package:connectivity/connectivity.dart';

int balance = 0;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(
            height: 10,
          ),
          CardBalance(),
          const SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: const Text(
              "Cours des cryptos",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FutureCrypto(
                  crypto_name: "BTC",
                  couleur: vert,
                ),
                FutureCrypto(
                  crypto_name: "ETH",
                  couleur: purple,
                ),
                FutureCrypto(
                  crypto_name: "XMR",
                  couleur: yellowCrypto,
                ),
                FutureCrypto(
                  crypto_name: "XRP",
                  couleur: orangeshade100,
                ),
                FutureCrypto(
                  crypto_name: "TUSD",
                  couleur: orange,
                ),
              ],
            ),
          ),
          LastDepense(),
        ],
      ),
    );
  }
}

class CardBalance extends StatelessWidget {
  final balanceSum = FirebaseFirestore.instance.collection('Balance').get();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: balanceSum,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Error occured");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }

        snapshot.data!.docs.forEach((element) {
          balance = balance + element['balance'] as int;
        });

        return Container(
          margin: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          padding: const EdgeInsets.all(20),
          height: 200,
          decoration: BoxDecoration(
            color: black,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${balance.toString()}€",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(-15, 0),
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "4899 **** **** 1548",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class FutureCrypto extends StatelessWidget {
  final String crypto_name;
  final Color couleur;

  FutureCrypto({required this.crypto_name, required this.couleur});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CryptoModel>(
      future: createCryptos(crypto_name),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CryptoPrice(
            crypto_price: snapshot.data!.price,
            crypto_name: crypto_name,
            couleur: couleur,
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Une erreur est survenu",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w200,
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
    );
  }
}

class CryptoPrice extends StatelessWidget {
  final String crypto_name;
  final double crypto_price;
  final Color couleur;

  CryptoPrice(
      {required this.crypto_name,
      required this.crypto_price,
      required this.couleur});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: this.couleur,
            ),
            width: 15,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
          ),
          Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              Text(
                "${this.crypto_name}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                "${this.crypto_price}€",
                style: TextStyle(
                  color: this.couleur,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LastDepense extends StatefulWidget {
  @override
  _MyLastDepense createState() => _MyLastDepense();
}

class _MyLastDepense extends State<LastDepense> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(25),
      child: Column(
        children: [
          Linedepense(),
        ],
      ),
    );
  }
}

class Linedepense extends StatefulWidget {
  @override
  _MyLineDepense createState() => _MyLineDepense();
}

class _MyLineDepense extends State<Linedepense> {
  final Stream<QuerySnapshot> _depenseStream =
      FirebaseFirestore.instance.collection('Depenses').limit(10).snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _depenseStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text(
            "Une erreur est survenue.",
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              ListView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> datas =
                      document.data()! as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: background,
                          child: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              datas['categorie'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              datas['date'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${datas['depense'].toString()}€",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
