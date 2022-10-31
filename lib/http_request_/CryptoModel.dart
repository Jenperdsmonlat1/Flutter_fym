class CryptoModel {
  final double price;

  const CryptoModel({required this.price});

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      price: json['EUR'] as double,
    );
  }
}
