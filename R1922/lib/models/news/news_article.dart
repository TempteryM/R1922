import 'package:hive/hive.dart';
part 'news_article.g.dart';

@HiveType(typeId: 19)
class NewsArticle {
  @HiveField(0)
  final String urlButton;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String urlImage;
  @HiveField(3)
  final String dateNews;

  const NewsArticle({
    required this.title,
    required this.urlButton,
    required this.urlImage,
    required this.dateNews,
  });
  static NewsArticle fromJson(json) => NewsArticle(
      title: json['title'],
      urlButton: json['urlButton'],
      urlImage: json['urlImage'],
      dateNews: json['dateNews']);
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'urlButton': urlButton,
      'urlImage': urlImage,
      'dateNews': dateNews
    };
  }
}
