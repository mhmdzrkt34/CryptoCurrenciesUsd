import 'package:currenciesusd/inventories/routes_inventory.dart';
import 'package:currenciesusd/modelviews/coin_info_model_view.dart';
import 'package:currenciesusd/modelviews/home_model_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  GetIt.instance.registerSingleton<HomeModelView>(HomeModelView());
  GetIt.instance.registerSingleton<CoinInfoModelView>(CoinInfoModelView());


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    if(!GetIt.instance.isRegistered<RoutesInventory>()){

      GetIt.instance.registerSingleton<RoutesInventory>(RoutesInventory(context: context));
    }

    return MaterialApp(


      title: "CurrenciesUsd",

      initialRoute: "HomeView",
      routes: GetIt.instance.get<RoutesInventory>().getRoutes(),


    );

  }
}



