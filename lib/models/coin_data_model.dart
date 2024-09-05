import 'dart:ffi';

class CoinDataModel {


  late String id;
  late String symbol;

  late String name;

  late String description;
  late String image;

  late dynamic price;

  CoinDataModel({required this.id,required this.symbol,required this.name,required this.description,required this.image,
  
  required this.price
  });


  static CoinDataModel fromJson(Map<String,dynamic>  json){


    return CoinDataModel(description:json["description"]['en'],id:json["id"],symbol: json["symbol"],
    
    name: json["name"],
    image: json["image"]["large"],
    price: json["market_data"]["current_price"]["usd"]
     );
  }


}