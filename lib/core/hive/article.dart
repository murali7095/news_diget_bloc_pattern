import 'package:hive/hive.dart';
import 'everything_source.dart'; // Import the EverythingSource model

part 'article.g.dart'; // This is generated by the build_runner

@HiveType(typeId: 1)
class ArticleModelData extends HiveObject {
  @HiveField(0)
  final EverythingSourceModelData source;

  @HiveField(1)
  final String author;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String url;

  @HiveField(5)
  final String urlToImage;

  @HiveField(6)
  final String publishedAt;

  @HiveField(7)
  final String content;

  ArticleModelData({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });
}
