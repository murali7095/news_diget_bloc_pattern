import 'dart:convert';

import 'package:news_digest/features/dashboard/data/data_source/dashboard_data_source.dart';
import 'package:news_digest/features/dashboard/model/catageory_model.dart';
import 'package:news_digest/features/dashboard/model/everything_model.dart';
import 'package:news_digest/features/dashboard/model/head_lines_model.dart';

class DashboardRepository{

  DashboardRepository();
  Future<EverythingModel> fetchEverythingNews()async{
    EverythingModel everythingNewsModel =EverythingModel(status: '',articles: [],totalResults: 0);
    try{
      final response =await DashboardDataSource().getEverythingNewsApi();
      if(response.statusCode ==200){
        final  jsonData = jsonDecode(response.body);

        everythingNewsModel = EverythingModel.fromJson(jsonData);
      }
      return everythingNewsModel ;
    }catch(e){

      throw e.toString();
    }
  }
  Future<CatageoryModel> fetchCatageoryNews({required String category, String searchText=''})async{
    CatageoryModel catageoryModel =CatageoryModel(status: '',articles: [],totalResults: 0);
    try{
      final response =await DashboardDataSource().fetchCatageoryNews(category: category, );
      if(response.statusCode ==200){
        final  jsonData = jsonDecode(response.body);

        catageoryModel = CatageoryModel.fromJson(jsonData);
      }
      return catageoryModel ;
    }catch(e){

      throw e.toString();
    }
  }
  Future<HeadLinesModel> fetchTheTopHeadlines()async{
    HeadLinesModel headlines =HeadLinesModel(status: '',articles: [],totalResults: 0);
    try{
      final response =await DashboardDataSource().fetchTopHeadLines(category: '');
      if(response.statusCode ==200){
        final  jsonData = jsonDecode(response.body);

        headlines = HeadLinesModel.fromJson(jsonData);
      }
      return headlines ;
    }catch(e){

      throw e.toString();
    }
  }
}