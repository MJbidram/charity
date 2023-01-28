class DamandModle {
  int id;
  String title;
  String description;
  String date;
  String status;

  DamandModle(this.id, this.title, this.description, this.date, this.status);
  factory DamandModle.fromJsonMap(Map<String, dynamic> jsonObject) {
    return DamandModle(
      jsonObject['id'],
      jsonObject['title'],
      jsonObject['description'],
      jsonObject['date'],
      jsonObject['status'],
    );
  }
}

class DamandTypeModel {
  int id;
  String idType;
  String title;

  DamandTypeModel(this.id, this.title, this.idType);
}
