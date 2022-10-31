import 'dart:convert';
import 'package:http/http.dart' as http;
import 'CryptoModel.dart';

Future<CryptoModel> createCryptos(String symbol) async {
  final response = await http.get(
    Uri.parse(
        "https://min-api.cryptocompare.com/data/price?fsym=$symbol&tsyms=EUR"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return CryptoModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error");
  }
}
