import 'package:currenciesusd/models/coin_model.dart';
import 'package:currenciesusd/modelviews/home_model_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CoinMobileComponent extends StatelessWidget {



  late CoinModel coin;



  CoinMobileComponent({required this.coin});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  
    SizedBox(width: double.infinity,
    child:   
    
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

         Expanded(child:  Container(
          margin: EdgeInsets.only(right: 10),
   
      child:Text(coin.name) ,)),

      MaterialButton(onPressed: (){
        print(coin.name);
        GetIt.instance.get<HomeModelView>().viewPress(coin.id);


      }, child: Text("view",style: TextStyle(color: Colors.white),),
      color: Colors.blue,
      )
    ],)



    );
  
  }
}