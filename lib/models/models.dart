import 'package:charity/screens/widget/news_cover.dart';

class HomePooyeshModel {
  int idPooyeshHome;
  String titlePooyeshHome;
  String imagePooyeshHome;

  HomePooyeshModel({
    required this.idPooyeshHome,
    required this.imagePooyeshHome,
    required this.titlePooyeshHome,
  });

  factory HomePooyeshModel.fromJsonMap(Map<String, dynamic> jsonObject) {
    return HomePooyeshModel(
        idPooyeshHome: jsonObject['id'],
        titlePooyeshHome: jsonObject['title'],
        imagePooyeshHome: jsonObject['image']);
  }
}

class HomeProjectsModel {
  int idProjectHome;
  String titleProjectHome;
  String imageProjectHome;
  int pishraftProjectHome;

  HomeProjectsModel({
    required this.idProjectHome,
    required this.imageProjectHome,
    required this.titleProjectHome,
    required this.pishraftProjectHome,
  });

  factory HomeProjectsModel.fromJsonMap(Map<String, dynamic> jsonObject) {
    return HomeProjectsModel(
      idProjectHome: jsonObject['id'],
      titleProjectHome: jsonObject['title'],
      imageProjectHome: jsonObject['image_head'],
      pishraftProjectHome: jsonObject['pishraft'],
    );
  }
}

class HadisModel {
  /// Hadis
  String teller;
  String arabicText;
  String farsiText;
  String source;
  String group;

  HadisModel(
    this.teller,
    this.arabicText,
    this.farsiText,
    this.source,
    this.group,
  );

  factory HadisModel.fromeJsonMap(Map<String, dynamic> jsonObject) {
    return HadisModel(
      jsonObject['gala'],
      jsonObject['arabi'],
      jsonObject['farsi'],
      jsonObject['manba'] ?? 'null',
      jsonObject['group'] ?? 'null',
    );
  }
}

class PooyeshesModel {
  String pooyeshImageUrl;
  String pooyeshTitle;
  int pooyeshId;
  String description;
  int amount;
  String start;
  String end;
  int type_pay;
  PooyeshesModel(
    this.pooyeshId,
    this.pooyeshTitle,
    this.pooyeshImageUrl,
    this.description,
    this.amount,
    this.start,
    this.end,
    this.type_pay,
  );
  factory PooyeshesModel.fromeJsonMap(Map<String, dynamic> jsonObject) {
    return PooyeshesModel(
      jsonObject['id'],
      jsonObject['title'],
      jsonObject['image'],
      jsonObject['description'],
      jsonObject['amount'],
      jsonObject['start'] ?? 'null',
      jsonObject['end'] ?? 'null',
      jsonObject['type_pay'] ?? 'null',
    );
  }
}

class ProjectModel {
  int projectId;
  String projectSlug;
  String projectTitle;
  String projectDescription;
  String projectImageUrl;
  int projectPishraft;
  String projectTag;

  ProjectModel(
    this.projectId,
    this.projectSlug,
    this.projectTitle,
    this.projectDescription,
    this.projectImageUrl,
    this.projectPishraft,
    this.projectTag,
  );
  factory ProjectModel.fromeJsonMap(Map<String, dynamic> jsonObject) {
    return ProjectModel(
      jsonObject['id'],
      jsonObject['slug'],
      jsonObject['title'],
      jsonObject['description'],
      jsonObject['image_head'],
      jsonObject['pishraft'] ?? 0,
      jsonObject['tags'] ?? 'null',
    );
  }
}

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
