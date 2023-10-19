class PriceData {
  final String price;

  PriceData({required this.price});

  factory PriceData.fromJson(Map<String, dynamic> json) {
    return PriceData(
      price: json['05. price'] ?? '', 
    );
  }
}
