import 'package:currenciesusd/components/coin_component.dart/coin_mobile_component.dart';
import 'package:currenciesusd/models/coin_model.dart';
import 'package:currenciesusd/modelviews/home_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HomeMobileView extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {


    return HomeMobileViewState();

  }
}


class HomeMobileViewState extends State<HomeMobileView> {

  
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(child:

      Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20)  ,
      
      child: 
      SizedBox(height: double.infinity,
      child: Column(children: [
        SearchSelector(),



        Expanded(child: coinsListner())
      ],),
      )
      )

 
      
      )
    );

  }


 Selector<HomeModelView,Tuple2<bool,List<CoinModel>?>> coinsListner(){

  return Selector<HomeModelView,Tuple2<bool,List<CoinModel>?>>(selector: (context,provider)=>
  Tuple2(provider.getCoinsException,provider.filteredCoins),
  shouldRebuild: (previous,next)=>!identical(previous.item1, next.item1) || !identical(previous.item2, next.item2)

  ,
  builder: (context,value,child){

    return coins(value);



  },
  );
 }


 Widget coins(Tuple2<bool,List<CoinModel>?> value){

  if(value.item1==true){


    return Center(child: 
    GestureDetector(
      onTap: (){

        GetIt.instance.get<HomeModelView>().getCoins();
      },
      child: Icon(Icons.replay),
    )
    ,);
  }

  if(value.item2==null){

    return Center(child: CircularProgressIndicator(),);
  }

  return ListView.builder(itemCount: value.item2!.length, itemBuilder: (BuildContext context,int index){


    return CoinMobileComponent(coin: value.item2![index]);




  });

  


 }

 Selector<HomeModelView,List<CoinModel>?> SearchSelector(){


  return Selector<HomeModelView,List<CoinModel>?>(selector: (context,provider)=>provider.filteredCoins,
  
  shouldRebuild: (previous,next)=>!identical(previous, next),

  builder: (context,value,child){
    if(value==null){
      return SizedBox();
    }
    return        SizedBox(width: double.infinity,
       child: TextFormField(
        onChanged: (value){
          GetIt.instance.get<HomeModelView>().searchChange(value);


        },
        cursorColor: Colors.blue,
        decoration: InputDecoration(prefixIcon: Icon(Icons.search,color: Colors.blue,),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0), // Default border
              borderRadius: BorderRadius.circular(8.0), // Rounded corners if desired
            ),
        
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0), // Blue border when focused
              borderRadius: BorderRadius.circular(8.0),
            ),
        ),
        controller: GetIt.instance.get<HomeModelView>().searchController,),);

  },
  );




 }
 
}
