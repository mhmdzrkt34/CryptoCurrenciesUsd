import 'package:currenciesusd/views/coininfoview/coin_info_view.dart';
import 'package:currenciesusd/views/homeview/home_desktop_view.dart';
import 'package:currenciesusd/views/homeview/home_mobile_view.dart';
import 'package:currenciesusd/views/homeview/home_view.dart';
import 'package:flutter/material.dart';

class RoutesInventory {


  late Map<String,WidgetBuilder> _routes;



  late BuildContext context;




  RoutesInventory({required this.context}){

    _routes={

      "HomeView":(context)=>HomeView(homeDesktopView: HomeDesktopView(), homeMobileView: HomeMobileView()),

      "CoinInfoView":(context)=>CoinInfoView()




    };






  }

   Map<String,WidgetBuilder> getRoutes(){

    return this._routes;


  }





}