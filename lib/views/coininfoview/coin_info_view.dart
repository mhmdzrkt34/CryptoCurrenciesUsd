import 'package:currenciesusd/models/coin_data_model.dart';
import 'package:currenciesusd/modelviews/coin_info_model_view.dart';
import 'package:currenciesusd/modelviews/home_model_view.dart';
import 'package:currenciesusd/views/homeview/home_desktop_view.dart';
import 'package:currenciesusd/views/homeview/home_mobile_view.dart';
import 'package:currenciesusd/views/homeview/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class CoinInfoView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return CoinInfoViewState();

  }
}

class CoinInfoViewState extends State<CoinInfoView> {

  late double _deviceWidth;
  late double _deviceHeight;
  


  @override
  Widget build(BuildContext context) {

        double safeAreaTopPadding = MediaQuery.of(context).padding.top;
    double safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height-safeAreaTopPadding-safeAreaBottomPadding;

    return MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<CoinInfoModelView>())],
    
    child: LayoutBuilder(builder: (BuildContext context,BoxConstraints constraint){


           if(constraint.maxWidth<600){

        return       Scaffold(


      body: SafeArea(child: Padding(padding: EdgeInsets.all(20),
      child: 

      coinListner()


      
  
      )),
    );
      }
      else {

        return HomeView(homeDesktopView: HomeDesktopView(), homeMobileView: HomeMobileView());
      }








    })
    );
    

  }
  @override
  void initState() {
    // TODO: implement initState'
    GetIt.instance.get<CoinInfoModelView>().onInitState();

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    GetIt.instance.get<CoinInfoModelView>().onDispose();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    if(!ModalRoute.of(context)!.isCurrent){


    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Selector<CoinInfoModelView,Tuple2<bool,CoinDataModel?>> coinListner(){


    return  Selector<CoinInfoModelView,Tuple2<bool,CoinDataModel?>>(selector: (context,provider)=>Tuple2(provider.getCoinInfoException,provider.coin),
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

          GetIt.instance.get<CoinInfoModelView>().getCoinInfo();
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


      ],),), onRefresh: GetIt.instance.get<CoinInfoModelView>().getCoinInfo);
 







    


  }
}