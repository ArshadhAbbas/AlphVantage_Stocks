class StockData {
  final String name;
  final String symbol;

  StockData({
    required this.name,
    required this.symbol,
  });

  factory StockData.fromJson(Map<String, dynamic> json) {
    return StockData(
      name: json['2. name'] ?? '',
      symbol: json['1. symbol'] ?? '',
    );
  }
}
