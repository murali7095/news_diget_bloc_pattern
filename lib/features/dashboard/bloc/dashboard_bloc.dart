import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:news_digest/core/hive/everything_source.dart';
import 'package:news_digest/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:news_digest/features/dashboard/model/catageory_model.dart';
import 'package:news_digest/features/dashboard/model/head_lines_model.dart';

import '../../../core/hive/article.dart';
import '../model/everything_model.dart' as every;
import '../model/everything_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  Box<ArticleModelData>? articleBox;
 // final ArticleService articleService = ArticleService();
  DashboardBloc() : super(DashboardInitial()) {
    on<GetEverythingNewsEvent>(_fetchEverythingNews);
    on<GetCatageoryEvent>(_fetchCatageoryNews);
    on<GetTopHeadlinesEvent>(_fetchTopHeadlines);
    on<CategorySelectedEvent>(_onCategorySelected);
    on<SearchTextEvent>(_onSearchNews);
    on<FetchAllSavedArticles>(_fetchSavedArticles);
    on<InitializeHiveDatabaseEvent>(_onHiveInitialization);

  }
  // Initialize the Hive box for articles
  Future<void> initHiveBox() async {
    // Ensure that the box is opened before being used.
    articleBox ??= await Hive.openBox<ArticleModelData>('saved_articles');
  }

  // Add a list of articles to the local database
  Future<void> addArticlesToDatabase(ArticleModelData articles) async {
    try {
      // Open the box if not already opened
      await initHiveBox();
      await articleBox?.add(articles);

    } catch (e) {

    }
  }

  // Fetch all articles from the local database
  Future<List<ArticleModelData>> getAllArticles() async {
    try {
      // Open the box if not already opened
      await initHiveBox();

      // Return all articles
      return articleBox?.values.toList() ?? [];
    } catch (e) {
      return [];
    }
  }

  // Event handler for saving articles to the database
  Future<void> saveArticlesToLocalDatabase({required Article article}) async {
    try {
      final theArticleDetails = ArticleModelData(
        source: EverythingSourceModelData(id: 'id', name: 'name'),
        author: article.author,
        title: article.title,
        description: article.description,
        url: article.url,
        urlToImage: article.urlToImage,
        publishedAt: article.publishedAt,
        content: article.content,
      );
      // Save the articles to the local database
      await addArticlesToDatabase(theArticleDetails);
    } catch (e) {

    }
  }
  List<Article> allSavedArticles=[];
  // Event handler to fetch all saved articles from Hive
  Future<void> _fetchSavedArticles(FetchAllSavedArticles event, Emitter<DashboardState> emit) async {
    try {
      emit(DashboardLoading());
      List<ArticleModelData> articleModel = await getAllArticles();
      allSavedArticles  = articleModel.map((e) {
        return Article(
          source: every.EverythingSource(id: "id", name: "name"),
          author: e.author,
          title: e.title,
          description: e.description,
          url: e.url,
          urlToImage: e.urlToImage,
          publishedAt: e.publishedAt,
          content: e.content,
        );
      }).toList();

      // Emit the success state with the list of saved articles
      emit(FetchSavedArticlesSuccess(allSavedArticles: allSavedArticles));
    } catch (e) {
      //emit(DashboardLoading());
       emit(FetchSavedArticlesFailure(error: e.toString()));  // Emit failure state
    }
  }

  // Event handler for initializing Hive
  Future<void> _onHiveInitialization(InitializeHiveDatabaseEvent event, Emitter<DashboardState> emit) async {
    await initHiveBox();
  }
  final List<String> categories = [
    "All",  "general", "health",
     "sports", "technology"
  ];

  String currentCategory = 'All';
  String searchNews = '';
  // Event handler for category selection
  void _onCategorySelected(CategorySelectedEvent event, Emitter<DashboardState> emit) {
    currentCategory = event.selectedCategory;  // Update the current category

    emit(CategorySelectedState(currentCategory));  // Emit the new state with the selected category
  }
  void _onSearchNews(SearchTextEvent event, Emitter<DashboardState> emit) {
    searchNews = event.searchText;  // Update the current category

    emit(SearchTextState(searchNews));  // Emit the new state with the selected category

  }
  _fetchEverythingNews(GetEverythingNewsEvent event, Emitter<DashboardState> emit) async{

    emit(DashboardLoading());
    try{
      final EverythingModel data = await DashboardRepository().fetchEverythingNews();
      emit(FetchEverythingSuccess(everythingModel: data));

    }catch(e){
      emit(FetchEverythingFailure(  error: e.toString()));
    }
  }
  int selectedIndex = 0;
  _fetchCatageoryNews(GetCatageoryEvent event, Emitter<DashboardState> emit) async{

    emit(DashboardLoading());
    try{
      final CatageoryModel data = await DashboardRepository().fetchCatageoryNews(category: currentCategory,searchText: searchNews);
      emit(FetchCatageorySuccess(catageoryModel: data));

    }catch(e){
      emit(FetchCatageoryFailure(  error: e.toString()));
    }
  }
  _fetchTopHeadlines(GetTopHeadlinesEvent event, Emitter<DashboardState> emit) async{

    emit(DashboardLoading());
    try{
      final HeadLinesModel data = await DashboardRepository().fetchTheTopHeadlines();
      emit(FetchTopHeadlinesSuccess( headLinesModel: data));
    }catch(e){
      emit(FetchHeadlinesFailure(  error: e.toString()));
    }
  }
}
