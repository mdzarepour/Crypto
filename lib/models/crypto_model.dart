class CryptoModel {
  late String id;
  late int rank;
  late String symbol;
  late String name;
  late double supply;
  late double priceUsd;
  late double changePercent24Hr;
  CryptoModel({
    required this.id,
    required this.changePercent24Hr,
    required this.name,
    required this.priceUsd,
    required this.rank,
    required this.supply,
    required this.symbol,
  });
  factory CryptoModel.fromJsonObject(Map<String, dynamic> jsonBody) {
    return CryptoModel(
      id: jsonBody['id']!,
      changePercent24Hr: double.parse(jsonBody['changePercent24Hr']!),
      name: jsonBody['name']!,
      priceUsd: double.parse(jsonBody['priceUsd']!),
      rank: int.parse(jsonBody['rank']!),
      supply: double.parse(jsonBody['supply']!),
      symbol: jsonBody['symbol']!,
    );
  }
}
