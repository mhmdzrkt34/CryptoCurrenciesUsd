import 'package:currenciesusd/Sevices/coin_gecko_service.dart/coin_gecko_service_base.dart';
import 'package:currenciesusd/Sevices/coin_gecko_service.dart/coint_gecko_service_api.dart';
import 'package:currenciesusd/models/coin_data_model.dart';
import 'package:currenciesusd/modelviews/home_model_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CoinInfoModelView extends ChangeNotifier {




   String? currentCoinId;


   CoinDataModel? coin;
   bool getCoinInfoException=false;

     CoinGeckoServiceBase _coinGeckoApiService= CoinGeckoServiceApi();






   CoinInfoModelView();


   void setCurrentCoindId(String id){

    currentCoinId=id;
    print(currentCoinId);
   }

   void onDispose(){

    currentCoinId=null;
    coin=null;
   }

   Future<void> getCoinInfo() async{

    try{


      coin=null;

      

      getCoinInfoException=false;

      notifyListeners();

      Response response=await _coinGeckoApiService.getCoinInfo(currentCoinId!);

      Map<String,dynamic> responceData=response.data as Map<String,dynamic>; 

      CoinDataModel coinfetched=CoinDataModel.fromJson(responceData);

      coin=coinfetched;
      notifyListeners();


            GetIt.instance.get<HomeModelView>().setCoin(coinfetched);










    }catch(e){
      print(e);

      getCoinInfoException=true;
      notifyListeners();


    }
   }

   Future<void> onInitState() async{


    await getCoinInfo();


   }

   

   
   void setCoin(CoinDataModel coinn){
    coin=coinn;

    notifyListeners();

    
   }




}