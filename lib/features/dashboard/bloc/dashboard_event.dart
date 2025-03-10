part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

final class GetEverythingNewsEvent extends DashboardEvent{}
final class GetTopHeadlinesEvent extends DashboardEvent{}
final class GetCatageoryEvent extends DashboardEvent{}
final class CatageorySelection extends DashboardEvent{}
class CategorySelectedEvent extends DashboardEvent {
  final String selectedCategory;

  CategorySelectedEvent({required this.selectedCategory});
}
class SearchTextEvent extends DashboardEvent {
  final String searchText;

  SearchTextEvent({required this.searchText});
}

class InitializeHiveDatabaseEvent extends DashboardEvent{

}
class FetchAllSavedArticles extends DashboardEvent{

}
class SaveArticlesEvent extends DashboardEvent {
  final List<ArticleModelData> articles;

  SaveArticlesEvent({required this.articles});}
