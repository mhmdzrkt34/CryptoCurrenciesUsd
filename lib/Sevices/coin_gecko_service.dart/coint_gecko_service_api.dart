import 'package:currenciesusd/Sevices/coin_gecko_service.dart/coin_gecko_service_base.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

class CoinGeckoServiceApi implements CoinGeckoServiceBase {


  final Dio dio=Dio();

  CoinGeckoServiceApi(){

    dio.options.baseUrl="https://api.coingecko.com/api/v3/";

 
      dio.options.headers = {
        "Accept": 'application/json',
        "Content-Type": "application/json",
        "x-cg-pro-api-key":"CG-NyXoPVpEm4roAnHbeKvT9MLF",
       


      };
  }
  @override
  Future<Response> getCoins() async{

    try{

      
      
      Response response=await dio.get("coins/list");

      
     


      return response;


    }catch(e){
      print(e);


      throw e;
    
  }

  
}

  @override
  Future<Response> getCoinInfo(String id) async{

    try{


      Response response=await dio.get("coins/${id}");

      return response;


    }catch(e){

      throw e;
    }

  }


}