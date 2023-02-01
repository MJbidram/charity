//لیست درخواست های کاربر
class DamandListModle {
  int id;
  String title;
  String description;
  // String? date;
  String status;

  DamandListModle(
      this.id,
      this.title,
      this.description,
      //  this.date,
      this.status);
  factory DamandListModle.fromJsonMap(Map<String, dynamic> jsonObject) {
    return DamandListModle(
      jsonObject['id'],
      jsonObject['title'],

      jsonObject['description'],
      // jsonObject['date'],

      jsonObject['status_title'],
    );
  }
}

//نوع درخواست ها
class DamandFirstTypeModel {
  int id;
  String title;
  String description;
  DamandFirstTypeModel(this.id, this.title, this.description);
  factory DamandFirstTypeModel.fromJsonMap(Map<String, dynamic> jsonObject) {
    return DamandFirstTypeModel(
      jsonObject['id'],
      jsonObject['title'],
      jsonObject['description'],
    );
  }
}

//نوع درخواست ها (زیرمجموعه)
class DamandSecandTypeModel {
  int id;
  String title;
  String description;
  DamandSecandTypeModel(this.id, this.title, this.description);
  factory DamandSecandTypeModel.fromJsonMap(Map<String, dynamic> jsonObject) {
    return DamandSecandTypeModel(
      jsonObject['id'],
      jsonObject['title'],
      jsonObject['description'],
    );
  }
}

class CreatDamandModel {
  int id;
  String title;
  String description;
  String date;
  String status;

  CreatDamandModel(
      this.id, this.title, this.description, this.date, this.status);
  factory CreatDamandModel.fromJsonMap(Map<String, dynamic> jsonObject) {
    return CreatDamandModel(
      jsonObject['id'],
      jsonObject['title'],
      jsonObject['description'],
      jsonObject['date'],
      jsonObject['status'],
    );
  }
}
