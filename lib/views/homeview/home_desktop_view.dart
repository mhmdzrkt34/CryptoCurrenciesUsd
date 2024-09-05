import 'package:currenciesusd/components/coin_component.dart/coin_desktop_component.dart';
import 'package:currenciesusd/models/coin_data_model.dart';
import 'package:currenciesusd/models/coin_model.dart';
import 'package:currenciesusd/modelviews/home_model_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HomeDesktopView extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {

    return HomeDesktopViewState();

  }
}

class HomeDesktopViewState extends State<HomeDesktopView> {

  late double _deviceWidth;
  late double _deviceHeight;

   
  


  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;

    _deviceHeight=MediaQuery.of(context).size.height;


    
    return Scaffold(
      body: SafeArea(child: Container(
        

        width: _deviceWidth,
        height: _deviceHeight,

        child: Row(

          children: [Container(
            color: Colors.blue,
         
            width: _deviceWidth*0.3,
          height: _deviceHeight,
          child: Column(children: [SearchSelector(),Expanded(child: coinsListner())],),
          ),
          
       Expanded(child: Container(height: _deviceHeight,
       
      child: coinListner(),))
          ],
        ),
      )),
    );

  }



  Selector<HomeModelView,Tuple2<bool,List<CoinModel>?>> coinsListner(){


    return Selector<HomeModelView,Tuple2<bool,List<CoinModel>?>>(selector: (context,provider)=>Tuple2(provider.getCoinsException, provider.filteredCoins),

    shouldRebuild: (previous,next)=>!identical(previous, next),


    builder: (context,value,child){

      return coins(value);

    },
    
    
    );
  }
  


  Widget coins(Tuple2<bool,List<CoinModel>?> value){


    if(value.item1==true){


      return Center(child: GestureDetector(
      onTap: (){

        GetIt.instance.get<HomeModelView>().getCoins();
      },
        child: Icon(Icons.replay),),);
    }

    if(value.item2==null){

      return Center(child: CircularProgressIndicator(),);
    }


    return ListView.builder(itemCount: value.item2!.length, itemBuilder: (BuildContext context,int index){

      return CoinDesktopComponent(coin: value.item2![index]);



    });


  }

   Selector<HomeModelView,List<CoinModel>?> SearchSelector(){


  return Selector<HomeModelView,List<CoinModel>?>(selector: (context,provider)=>provider.filteredCoins,
  
  shouldRebuild: (previous,next)=>!identical(previous, next),

  builder: (context,value,child){
    if(value==null){
      return SizedBox();
    }
    return       
     TextFormField(
        onChanged: (value){
          GetIt.instance.get<HomeModelView>().searchChange(value);


        },
        cursorColor: Colors.white,
        decoration: InputDecoration(prefixIcon: Icon(Icons.search,color: Colors.white,),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0), // Default border
              borderRadius: BorderRadius.circular(8.0), // Rounded corners if desired
            ),
        
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0), // Blue border when focused
              borderRadius: BorderRadius.circular(8.0),
            ),
        ),
        controller: GetIt.instance.get<HomeModelView>().searchController,);

  },
  );




 }

   Selector<HomeModelView,Tuple2<bool,CoinDataModel?>> coinListner(){


    return  Selector<HomeModelView,Tuple2<bool,CoinDataModel?>>(selector: (context,provider)=>Tuple2(provider.getCoinInfoException,provider.coin),
    shouldRebuild: (previous,next)=>!identical(previous.item1, next.item1) || !identical(previous.item2, next.item2),

    builder: (context,value,child){

      return coin(value);


    },
    );



  }

  Widget coin(Tuple2<bool,CoinDataModel?> value){

    if(value.item1==true){

      return Center(child: GestureDetector(
        onTap: (){

          GetIt.instance.get<HomeModelView>().getCoinInfo();
        },
        child: Icon(Icons.replay),),);
    }

    if(value.item2==null){

      return Center(child: CircularProgressIndicator(),);
    }

    return  
    
    RefreshIndicator(child: SingleChildScrollView(child:     Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


        Container(
          width: _deviceWidth*0.23,
          height: _deviceWidth*0.23,
               margin: EdgeInsets.only(bottom: 10),

          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(value.item2!.image),fit: BoxFit.cover)),
        ),

        Container(
          margin: EdgeInsets.only(bottom: 10),
          width: _deviceWidth,
          child: Text("name:${value.item2!.name}",style: TextStyle(fontSize: _deviceWidth*0.05),),),

          
        Container(
               margin: EdgeInsets.only(bottom: 10),
          width: _deviceWidth,
          child: Text("price:${value.item2!.price.toString()}\$",style: TextStyle(fontSize: _deviceWidth*0.05),),),

 Container(child: Text("description:${value.item2!.description}",style: TextStyle(fontSize: _deviceWidth*0.04)),),


      ],),), onRefresh: GetIt.instance.get<HomeModelView>().getCoinInfo);
 







    


  }
}