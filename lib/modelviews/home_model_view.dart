

import 'package:currenciesusd/Sevices/coin_gecko_service.dart/coin_gecko_service_base.dart';
import 'package:currenciesusd/Sevices/coin_gecko_service.dart/coint_gecko_service_api.dart';
import 'package:currenciesusd/models/coin_data_model.dart';
import 'package:currenciesusd/models/coin_model.dart';
import 'package:currenciesusd/modelviews/coin_info_model_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class HomeModelView extends ChangeNotifier {


  TextEditingController searchController=TextEditingController(text: "");

   BuildContext? currentcontext;

   List<CoinModel>? coins;
   List<CoinModel>? filteredCoins;

  
   bool getCoinsException=false;


   
   String? currentCoinId;


   CoinDataModel? coin;

      bool getCoinInfoException=false;
      

         void setCurrentCoindId(String id){

    currentCoinId=id;
    print(currentCoinId);
   }



  CoinGeckoServiceBase _coinGeckoApiService= CoinGeckoServiceApi();

  HomeModelView(){

    getCoins();
  }

  



  Future<void> getCoins() async{

    List<CoinModel> coinsList=[];
   
    getCoinsException=false;
    notifyListeners();

        try{
    Response response=await _coinGeckoApiService.getCoins();


    List data=response.data as List;

    List<Map<String,dynamic>> jsonDataList=data.map((item){

      return item as Map<String,dynamic>;
    }).toList();

    for(Map<String,dynamic> jsonObject in jsonDataList){

      coinsList.add(CoinModel.fromJson(jsonObject));






    }

    coins=[...coinsList];
    filteredCoins=[...coinsList];
    notifyListeners();



    getCoinsException=false;
   

    notifyListeners();
    






    }catch(e){

     
      getCoinsException=true;
      notifyListeners();




    }




  }
      void searchChange(String value){

        searchController.text=value;

        if(value==""){
       

          filteredCoins=[...coins!];
          notifyListeners();
        }
        else{


      List<CoinModel> finded=coins!.where((item)=>item.name.toLowerCase().contains(value.toLowerCase())).toList();

      filteredCoins=[...finded];
      notifyListeners();}



    }











  void onDispose(){

    currentcontext=null;




  }

  void onBuild(BuildContext context){
    currentcontext=context;



  }


  void onHidden(){


  }

  void onInitState(){
    getCoins();


  }

  void viewPress(String id){

    GetIt.instance.get<CoinInfoModelView>().setCurrentCoindId(id);
    Navigator.pushNamed(currentcontext!, "CoinInfoView");


  }

  void coinPress(String id){

    setCurrentCoindId(id);
    getCoinInfo();


  }

     Future<void> getCoinInfo() async{

    try{

      coin=null;

      

      getCoinInfoException=false;

      notifyListeners();

      Response response=await _coinGeckoApiService.getCoinInfo(currentCoinId!);

      Map<String,dynamic> responceData=response.data as Map<String,dynamic>; 

      CoinDataModel coinfetched=CoinDataModel.fromJson(responceData);

      GetIt.instance.get<CoinInfoModelView>().setCoin(coinfetched);

      coin=coinfetched;
      notifyListeners();










    }catch(e){
      print(e);

      getCoinInfoException=true;
      notifyListeners();


    }
   }

   void setCoin(CoinDataModel coinn){
    coin=coinn;

    notifyListeners();

    
   }
}