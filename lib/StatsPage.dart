import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fym/bar/StatBar.dart';
import 'package:fym/bar/navBar.dart';
import 'package:fym/models/DepensesModel.dart';
import 'package:fym/ui/Color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

int balance = 0;
int recuSum = 0;
int depenseSum = 0;

class MyStatPage extends StatefulWidget {
  @override
  _MyStatPageState createState() => _MyStatPageState();
}

class _MyStatPageState extends State<MyStatPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatBar(),
      backgroundColor: background,
      bottomNavigationBar: navBar(),
      body: Container(
        color: black,
        child: Container(
          decoration: BoxDecoration(
            color: background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              TextLastDepense(),
              ChartDepense(),
              const SizedBox(
                height: 10,
              ),
              ReceiveMoney(),
              const SizedBox(
                height: 25,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    "Dépenses en fonctions des catégories",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ],
              ),
              PieDepenses(),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextLastDepense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('Depenses').get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Impossible de récupérer les informations");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: Colors.black,
          );
        }

        snapshot.data!.docs.forEach((element) {
          depenseSum = depenseSum + element['depense'] as int;
        });

        return Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Dépenses totales",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${depenseSum.toString()}€",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
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

class ChartDepense extends StatefulWidget {
  @override
  _MyChartDepense createState() => _MyChartDepense();
}

class _MyChartDepense extends State<ChartDepense> {
  List<DepensesData> depensesData = <DepensesData>[];

  @override
  void initState() {
    getDatas().then((value) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    super.initState();
  }

  Future<void> getDatas() async {
    final depenses =
        await FirebaseFirestore.instance.collection('Depenses').limit(10).get();
    List<DepensesData> datas = depenses.docs
        .map((e) => DepensesData(
            categorie: e.data()['categorie'],
            date: e.data()['date'],
            depense: e.data()['depense']))
        .toList();

    setState(() {
      depensesData = datas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      height: 250,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          SplineSeries<DepensesData, String>(
              dataSource: depensesData,
              xValueMapper: (DepensesData data, _) => data.date,
              yValueMapper: (DepensesData data, _) => data.depense),
        ],
      ),
    );
  }
}

class ReceiveMoney extends StatefulWidget {
  @override
  _MyReceiveMoney createState() => _MyReceiveMoney();
}

class _MyReceiveMoney extends State<ReceiveMoney> {
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('Recus').get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Une erreur est survenue");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }

        snapshot.data!.docs.forEach((element) {
          recuSum = recuSum + element['recu'] as int;
        });

        return Container(
          height: 65,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Sommes totales reçus",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
              Text(
                "${recuSum.toString()}€",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PieDepenses extends StatefulWidget {
  @override
  _MyPieDepenses createState() => _MyPieDepenses();
}

class _MyPieDepenses extends State<PieDepenses> {
  List<DepensesData> depensesData = <DepensesData>[];

  @override
  void initState() {
    getDatas().then((value) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    super.initState();
  }

  Future<void> getDatas() async {
    final depenses =
        await FirebaseFirestore.instance.collection('Depenses').get();
    List<DepensesData> datas = depenses.docs
        .map((e) => DepensesData(
            categorie: e.data()['categorie'],
            date: e.data()['date'],
            depense: e.data()['depense']))
        .toList();

    setState(() {
      depensesData = datas;
    });
  }

  @override
  Widget build(BuildContext build) {
    return Container(
      height: 200,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SfCircularChart(
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          DoughnutSeries<DepensesData, String>(
              dataSource: depensesData,
              xValueMapper: (DepensesData data, _) => data.categorie,
              yValueMapper: (DepensesData data, _) => data.depense,
              name: 'CategoriesDatas',
              cornerStyle: CornerStyle.bothCurve),
        ],
      ),
    );
  }
}
