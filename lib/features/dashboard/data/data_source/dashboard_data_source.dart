import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news_digest/core/api_constants.dart';
import 'package:news_digest/core/network/network_api_services.dart';
class DashboardDataSource{
  Future<http.Response> getEverythingNewsApi() async{
    try{
      //https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=API_KEY
     final http.Response response=  await NetworkApiServices().getApiResponse(ApiConstants.everything);
     return response;
    }on SocketException{
      rethrow;
    }on TimeoutException{
      rethrow;
    }
    catch(e){

      rethrow;
    }
}
Future<http.Response> fetchTopHeadLines({required String category}) async{
    try{

     final http.Response response=  await NetworkApiServices().getApiResponse(ApiConstants.topHeadLines);
     return response;
    }on SocketException{
      rethrow;
    }on TimeoutException{
      rethrow;
    }
    catch(e){

      rethrow;
    }
}
Future<http.Response> fetchCatageoryNews({required String category, String seachText=''}) async{
    try{
      final url = category.toLowerCase() =='all' ? ApiConstants.everything :"https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=${ApiConstants.apiKey}";
     final http.Response response=  await NetworkApiServices().getApiResponse(url);
     return response;
    }on SocketException{
      rethrow;
    }on TimeoutException{
      rethrow;
    }
    catch(e){

      rethrow;
    }
}
}