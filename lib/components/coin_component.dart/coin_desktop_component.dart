import 'package:currenciesusd/models/coin_model.dart';
import 'package:currenciesusd/modelviews/home_model_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CoinDesktopComponent extends StatelessWidget {



  late CoinModel coin;


  CoinDesktopComponent({required this.coin});


  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      
      onTap: (){

        GetIt.instance.get<HomeModelView>().coinPress(coin.id);


      },
      child: Container(

      

      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Text(coin.name,style: TextStyle(color: Colors.white),),
    ),);

  }


}