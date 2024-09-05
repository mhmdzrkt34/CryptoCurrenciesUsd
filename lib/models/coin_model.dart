class CoinModel {




  late String id;

  late String symbol;

  late String name;


  CoinModel({required this.id,required this.symbol,required this.name});




  static CoinModel fromJson(Map<String,dynamic> json){


    return CoinModel(id: json["id"],symbol: json["symbol"],name: json["name"]);
  }
}