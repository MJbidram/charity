// class MarasematModel {
//   MarasematModel({
//     required this.data,
//   });
//   late final List<Data> data;

//   MarasematModel.fromJson(Map<String, dynamic> json) {
//     data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['data'] = data.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

class MarasematModel {
  MarasematModel({
    required this.id,
    required this.charity,
    required this.createdBy,
    required this.location,
    required this.marhoomName,
    this.marasemType,
    required this.date,
    required this.isActive,
  });
  late final int id;
  late final int charity;
  late final int createdBy;
  late final String location;
  late final String marhoomName;
  late final String? marasemType;
  late final String date;
  late final int isActive;

  factory MarasematModel.fromJson(Map<String, dynamic> json) {
    return MarasematModel(
      id: json['id'],
      charity: json['charity'],
      createdBy: json['created_by'],
      location: json['location'],
      marhoomName: json['marhoom_name'],
      marasemType: json['marasem_type'],
      date: json['date'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['charity'] = charity;
    _data['created_by'] = createdBy;
    _data['location'] = location;
    _data['marhoom_name'] = marhoomName;
    _data['marasem_type'] = marasemType;
    _data['date'] = date;
    _data['is_active'] = isActive;
    return _data;
  }
}
