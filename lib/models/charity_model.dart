import 'package:hive/hive.dart';

class CharityModelFirst {
  int? id;

  String? typeName;

  int? sub;

  int? optionalSubSelect;

  String title;
  String? description;

  CharityModelFirst(
      {required this.id,
      required this.typeName,
      required this.sub,
      required this.optionalSubSelect,
      required this.title,
      required this.description});
  factory CharityModelFirst.fromJsonMap(Map<String, dynamic> jsonObject) {
    return CharityModelFirst(
        id: jsonObject['id'],
        typeName: jsonObject['type_name'],
        optionalSubSelect: jsonObject['optional_sub_select'],
        sub: jsonObject['sub'],
        title: jsonObject['title'],
        description: jsonObject['description']);
  }
}

class CharityModelSecand {
  int? id;

  String? typeName;

  int? sub;

  int? optionalSubSelect;

  String? title;
  String? description;

  CharityModelSecand({
    required this.id,
    required this.typeName,
    required this.sub,
    required this.optionalSubSelect,
    required this.title,
    required this.description,
  });
  factory CharityModelSecand.fromJsonMap(Map<String, dynamic> jsonObject) {
    return CharityModelSecand(
      id: jsonObject['id'],
      typeName: jsonObject['type_name'],
      optionalSubSelect: jsonObject['optional_sub_select'] ?? -1,
      sub: jsonObject['sub'] ?? 0,
      title: jsonObject['title'],
      description: jsonObject['description'],
    );
  }
}
