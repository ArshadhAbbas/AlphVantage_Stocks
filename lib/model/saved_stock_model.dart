import 'package:hive_flutter/hive_flutter.dart';
part 'saved_stock_model.g.dart';

@HiveType(typeId: 1)
class SavedStockModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String companyName;
  @HiveField(2)
  final String companySymbol;
  @HiveField(3)
  final String companyType;

  SavedStockModel({
    required this.companyName,
    required this.companySymbol,
    required this.companyType,
    this.id,
  });
}
