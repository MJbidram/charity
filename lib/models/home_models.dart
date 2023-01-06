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
