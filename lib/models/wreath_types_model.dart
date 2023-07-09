class WearthTypeModel {
  WearthTypeModel({
    required this.data,
  });
  late final List<Type> data;

  WearthTypeModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Type.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Type {
  Type({
    required this.id,
    this.meta,
    required this.charity,
    required this.title,
    required this.img,
    required this.amount,
    required this.count,
    required this.isActive,
  });
  late final int id;
  late final Null meta;
  late final int charity;
  late final String title;
  late final String img;
  late final int amount;
  late final int count;
  late final int isActive;

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meta = null;
    charity = json['charity'];
    title = json['title'];
    img = json['img'];
    amount = json['amount'];
    count = json['count'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['meta'] = meta;
    _data['charity'] = charity;
    _data['title'] = title;
    _data['img'] = img;
    _data['amount'] = amount;
    _data['count'] = count;
    _data['is_active'] = isActive;
    return _data;
  }
}
