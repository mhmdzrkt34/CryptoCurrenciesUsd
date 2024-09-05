import 'package:currenciesusd/modelviews/home_model_view.dart';
import 'package:currenciesusd/views/homeview/home_desktop_view.dart';
import 'package:currenciesusd/views/homeview/home_mobile_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget{

  late HomeDesktopView homeDesktopView;

  late HomeMobileView homeMobileView;



  HomeView({required this.homeDesktopView,required this.homeMobileView});



  @override
  State<StatefulWidget> createState() {


    return HomeViewState();

  }



}

class HomeViewState extends State<HomeView> {


  @override
  Widget build(BuildContext context) {

    GetIt.instance.get<HomeModelView>().onBuild(context);

    return MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<HomeModelView>())],
    child: LayoutBuilder(builder: (BuildContext context,BoxConstraints constraint){


      if(constraint.maxWidth<600){

        return HomeMobileView();
      }
      else {

        return HomeDesktopView();
      }


    }),);

  }
  @override
  void initState() {
    // TODO: implement initState
   
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    if(!ModalRoute.of(context)!.isCurrent){



    }
    super.didChangeDependencies();
  }
}