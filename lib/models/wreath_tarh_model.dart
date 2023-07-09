class WreathTarhModel {
  WreathTarhModel({
    required this.data,
  });
  late final List<WreathTarh> data;

  WreathTarhModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => WreathTarh.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class WreathTarh {
  WreathTarh({
    required this.id,
    required this.name,
    required this.img,
  });
  late final int id;
  late final String name;
  late final String img;

  WreathTarh.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['img'] = img;
    return _data;
  }
}
