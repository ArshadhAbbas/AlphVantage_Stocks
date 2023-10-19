class StockData {
  final String type;
  final String symbol;
  final String company;

  StockData({
    required this.type,
    required this.symbol,
    required this.company,
  });

  factory StockData.fromJson(Map<String, dynamic> json) {
    return StockData(
      type: json['type'] ?? '',
      symbol: json['symbol'] ?? '',
      company: json['company']?? '',
    );
  }
}
