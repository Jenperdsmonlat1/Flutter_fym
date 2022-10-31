import 'package:cloud_firestore/cloud_firestore.dart';

class DepensesData {
  final String? categorie;
  final String? date;
  final int? depense;

  DepensesData(
      {required this.categorie, required this.date, required this.depense});
}
