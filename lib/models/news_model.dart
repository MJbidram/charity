import 'package:persian_number_utility/persian_number_utility.dart';

class NewsModel {
  int newsId;
  String newsTitile;
  String newsText;
  String newsDate;
  String newsImageUrl;

  NewsModel({
    required this.newsId,
    required this.newsTitile,
    required this.newsText,
    required this.newsDate,
    required this.newsImageUrl,
  });

  factory NewsModel.fromJsonObject(Map<String, dynamic> jsonObject) {
    return NewsModel(
        newsId: jsonObject['id'],
        newsTitile: jsonObject['title']['rendered'],
        newsText: jsonObject['content']['rendered'],
        newsDate: jsonObject['date'],
        newsImageUrl: jsonObject['yoast_head_json']['og_image'][0]['url']);
  }
}
