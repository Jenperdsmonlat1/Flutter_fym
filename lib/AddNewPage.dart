import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fym/bar/navBar.dart';
import 'package:fym/bar/topBar.dart';
import 'package:fym/ui/Color.dart';

String categorie = "";

class MyAddNewPage extends StatefulWidget {
  @override
  _MyAddNewPageState createState() => _MyAddNewPageState();
}

class _MyAddNewPageState extends State<MyAddNewPage> {
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
            height: 25,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
            child: const Text(
              "Choisir une catégorie",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ChipCategories(),
          ),
          const SizedBox(
            height: 40,
          ),
          AddDepense(),
          const SizedBox(
            height: 5,
          ),
          AddRecu(),
        ],
      ),
    );
  }
}

class ChipCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        ActionChip(
          backgroundColor: Colors.orange.shade100,
          label: Text("Nourriture"),
          onPressed: () {
            categorie = "Nourriture";
          },
        ),
        const SizedBox(
          width: 10,
        ),
        ActionChip(
          backgroundColor: Colors.red.shade200,
          label: Text("Voiture"),
          onPressed: () {
            categorie = "Voiture";
          },
        ),
        const SizedBox(
          width: 10,
        ),
        ActionChip(
          backgroundColor: Colors.blue.shade200,
          label: Text("Maison"),
          onPressed: () {
            categorie = "Maison";
          },
        ),
        const SizedBox(
          width: 10,
        ),
        ActionChip(
          backgroundColor: Colors.greenAccent.shade200,
          label: Text("Santé"),
          onPressed: () {
            categorie = "Santé";
          },
        ),
        const SizedBox(
          width: 10,
        ),
        ActionChip(
          backgroundColor: Colors.deepPurpleAccent.shade100,
          label: Text("Multimedia"),
          onPressed: () {
            categorie = "Multimedia";
          },
        ),
        const SizedBox(
          width: 10,
        ),
        ActionChip(
          backgroundColor: Colors.amberAccent,
          label: Text("Autre"),
          onPressed: () {
            categorie = "Autre";
          },
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

class AddDepense extends StatefulWidget {
  @override
  _MyAddDepense createState() => _MyAddDepense();
}

class _MyAddDepense extends State<AddDepense> {
  final depenseController = TextEditingController();
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('Balance');

  int balance = 0;

  @override
  void dispose() {
    depenseController.dispose();
    super.dispose();
  }

  void getBalance() {
    ref.doc('LOvzdZxCsrwbDNslLHFX').get().then((value) {
      Map<String, dynamic> field = value.data() as Map<String, dynamic>;

      setState(() {
        balance = field['balance'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ajouter une dépense",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: depenseController,
            //initialValue: "0",
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              labelText: "Votre dépense",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.orange.shade200,
                    Colors.deepPurple.shade200,
                  ]),
            ),
            child: ElevatedButton(
              onPressed: () async {
                try {
                  DateTime now = DateTime.now();
                  DateTime date = DateTime(now.year, now.month, now.day);

                  String depenseText = depenseController.text;
                  int depense = int.parse(depenseText);

                  await FirebaseFirestore.instance.collection('Depenses').add({
                    'categorie': categorie,
                    'depense': depense,
                    'date': date.toString()
                  });

                  await FirebaseFirestore.instance
                      .collection('Balance')
                      .add({'balance': balance - depense});

                  final snack_bar = SnackBar(
                    content: const Text(
                      "Les informations ont bien été ajouté",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    backgroundColor: black,
                    behavior: SnackBarBehavior.floating,
                    elevation: 10,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snack_bar);
                } catch (e) {
                  final snack_bar = SnackBar(
                    content: const Text(
                      "Une erreur est survenue, laquelle ?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    backgroundColor: Colors.red.shade900,
                    behavior: SnackBarBehavior.floating,
                    elevation: 10,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snack_bar);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: const Text(
                "Valider",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddRecu extends StatefulWidget {
  @override
  _MyAddRecu createState() => _MyAddRecu();
}

class _MyAddRecu extends State<AddRecu> {
  final recuController = TextEditingController();
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('Balance');

  int balance = 0;

  @override
  void dispose() {
    recuController.dispose();
    super.dispose();
  }

  void getBalance() {
    ref.doc('LOvzdZxCsrwbDNslLHFX').get().then((value) {
      Map<String, dynamic> field = value.data() as Map<String, dynamic>;

      setState(() {
        balance = field['balance'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ajouter une somme reçu",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: recuController,
            //initialValue: "0",
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              labelText: "Votre reçu",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.orange.shade200,
                    Colors.deepPurple.shade200,
                  ]),
            ),
            child: ElevatedButton(
              onPressed: () async {
                try {
                  int recu = int.parse(recuController.text);

                  await FirebaseFirestore.instance
                      .collection("Recus")
                      .add({'recu': recu});

                  await FirebaseFirestore.instance
                      .collection('Balance')
                      .add({'balance': balance + recu});

                  final snack_bar = SnackBar(
                    content: const Text(
                      "Les informations ont bien été ajouté",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    backgroundColor: black,
                    behavior: SnackBarBehavior.floating,
                    elevation: 10,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snack_bar);
                } catch (e) {
                  final snack_bar = SnackBar(
                    content: const Text(
                      "Une erreur est survenue, laquelle ?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    backgroundColor: Colors.red.shade900,
                    behavior: SnackBarBehavior.floating,
                    elevation: 10,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snack_bar);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: const Text(
                "Valider",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
