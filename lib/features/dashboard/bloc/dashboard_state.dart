part of 'dashboard_bloc.dart';  // Ensure this is the first line in the file

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class FetchEverythingSuccess extends DashboardState {
  final EverythingModel everythingModel;
  FetchEverythingSuccess({required this.everythingModel});
}

final class FetchEverythingFailure extends DashboardState {
  final String error;

  FetchEverythingFailure({required this.error});
}

final class FetchCatageorySuccess extends DashboardState {
  final CatageoryModel catageoryModel;
  FetchCatageorySuccess({required this.catageoryModel});
}

final class FetchCatageoryFailure extends DashboardState {
  final String error;

  FetchCatageoryFailure({required this.error});
}

final class FetchTopHeadlinesSuccess extends DashboardState {
  final HeadLinesModel headLinesModel;
  FetchTopHeadlinesSuccess({required this.headLinesModel});
}
final class FetchSavedArticlesSuccess extends DashboardState {
  final List<Article> allSavedArticles;
  FetchSavedArticlesSuccess({required this.allSavedArticles});
}

final class FetchHeadlinesFailure extends DashboardState {
  final String error;

  FetchHeadlinesFailure({required this.error});
}
final class FetchSavedArticlesFailure extends DashboardState {
  final String error;

  FetchSavedArticlesFailure({required this.error});
}

class CategorySelectedState extends DashboardState {
  final String selectedCategory;
  CategorySelectedState(this.selectedCategory);
}

class SearchTextState extends DashboardState {
  final String searchText;
  SearchTextState(this.searchText);
}



