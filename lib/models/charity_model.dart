import 'package:hive/hive.dart';
part 'charity_model.g.dart';

@HiveType(typeId: 1)
class CharityModelFirst extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? typeName;
  @HiveField(2)
  int? sub;
  @HiveField(3)
  int? optionalSubSelect;
  @HiveField(4)
  String title;

  CharityModelFirst(
      {required this.id,
      required this.typeName,
      required this.sub,
      required this.optionalSubSelect,
      required this.title});
  factory CharityModelFirst.fromJsonMap(Map<String, dynamic> jsonObject) {
    return CharityModelFirst(
      id: jsonObject['id'],
      typeName: jsonObject['type_name'],
      optionalSubSelect: jsonObject['optional_sub_select'],
      sub: jsonObject['sub'],
      title: jsonObject['title'],
    );
  }
}

@HiveType(typeId: 2)
class CharityModelSecand extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? typeName;
  @HiveField(2)
  int? sub;
  @HiveField(3)
  int? optionalSubSelect;
  @HiveField(4)
  String? title;

  CharityModelSecand(
      {required this.id,
      required this.typeName,
      required this.sub,
      required this.optionalSubSelect,
      required this.title});
  factory CharityModelSecand.fromJsonMap(Map<String, dynamic> jsonObject) {
    return CharityModelSecand(
      id: jsonObject['id'],
      typeName: jsonObject['type_name'],
      optionalSubSelect: jsonObject['optional_sub_select'] ?? -1,
      sub: jsonObject['sub'] ?? 0,
      title: jsonObject['title'],
    );
  }
}
