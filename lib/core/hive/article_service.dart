// import 'package:hive/hive.dart';
// import 'package:news_digest/core/hive/article.dart';
//
//
//
// class ArticleService {
//   // Box to store articles in Hive
//   late Box<ArticleModelData> articleBox;
//
//   // Initialize the Hive box for articles
//   Future<void> initHiveBox() async {
//     articleBox = await Hive.openBox<ArticleModelData>('saved_articles');
//   }
//
//   // Add a list of articles to the local database
//   Future<void> addArticlesToDatabase( ArticleModelData articles) async {
//     try {
//       // Open the box (if not already opened)
//       await initHiveBox();
//       // Add each article to the box
//      // for (var article in articles) {
//         await articleBox.add(articles);
//     //  }
//
//       print('Articles added to local database.');
//     } catch (e) {
//       print('Error adding articles to Hive database: $e');
//     }
//   }
//
//   // Fetch all articles from the local database
//   Future<List<ArticleModelData>> getAllArticles() async {
//     try {
//       // Open the box (if not already opened)
//       //await initHiveBox();
//
//       // Return all articles
//       return articleBox.values.toList();
//     } catch (e) {
//       print('Error fetching articles from Hive database: $e');
//       return [];
//     }
//   }
// }
