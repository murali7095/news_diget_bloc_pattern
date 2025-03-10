

import 'package:news_digest/features/dashboard/model/everything_model.dart';

class HeadLinesModel {
  final String status;
  final int totalResults;
  final List<Article> articles;

  HeadLinesModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory HeadLinesModel.fromJson(Map<String, dynamic> json) {
    var articlesList = json['articles'] as List? ?? [];
    List<Article> articles = articlesList.map((i) => Article.fromJson(i)).toList();

    return HeadLinesModel(
      status: json['status'] ?? '', // Default to empty string if null
      totalResults: json['totalResults'] ?? 0, // Default to 0 if null
      articles: articles,
    );
  }
}

class HeadLinesArticle {
  final EverythingSource source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  HeadLinesArticle({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory HeadLinesArticle.fromJson(Map<String, dynamic> json) {
    return HeadLinesArticle(
      source: EverythingSource.fromJson(json['source'] ?? {}), // Empty map if null
      author: json['author'] ?? '', // Default to empty string if null
      title: json['title'] ?? '', // Default to empty string if null
      description: json['description'] ?? '', // Default to empty string if null
      url: json['url'] ?? '', // Default to empty string if null
      urlToImage: json['urlToImage'] ?? '', // Default to empty string if null
      publishedAt: json['publishedAt']  ?? '', // Default to current time if null
      content: json['content'] ?? '', // Default to empty string if null
    );
  }
}

class EverythingSource {
  final String id;
  final String name;

  EverythingSource({
    required this.id,
    required this.name,
  });

  factory EverythingSource.fromJson(Map<String, dynamic> json) {
    return EverythingSource(
      id: json['id'] ?? '', // Default to empty string if null
      name: json['name'] ?? '', // Default to empty string if null
    );
  }
}
