import 'package:dio/dio.dart';

abstract class CoinGeckoServiceBase {



     Future<Response> getCoins();
     Future<Response> getCoinInfo(String id);
}