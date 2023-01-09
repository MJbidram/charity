class CharityModelFirst {
  int? id;
  String? typeName;
  int? sub;
  int? optionalSubSelect;
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

class CharityModelSecand {
  int? id;
  String? typeName;
  int? sub;
  int? optionalSubSelect;
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
