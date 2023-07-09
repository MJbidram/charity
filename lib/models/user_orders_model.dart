class UserOrdersModel {
  UserOrdersModel({
    required this.id,
    required this.bename,
    this.status,
    required this.createdAt,
    required this.marhoomName,
    required this.isPardakht,
    required this.sabtid,
  });
  late final int id;
  late final String bename;
  late final String? status;
  late final String createdAt;
  late final String marhoomName;
  late final int isPardakht;
  late final String sabtid;

  // UserStatus.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   bename = json['bename'];
  //   status = null;
  //   createdAt = json['created_at'];
  //   marhoomName = json['marhoom_name'];
  //   isPardakht = json['is_pardakht'];
  //   sabtid = json['sabtid'];
  // }

  factory UserOrdersModel.fromJson(Map<String, dynamic> json) {
    return UserOrdersModel(
      id: json['id'],
      bename: json['bename'] ?? 'نامعلوم',
      status: json['status'] ?? 'نامعلوم',
      createdAt: json['created_at'] ?? 'نامعلوم',
      marhoomName: json['marhoom_name'] ?? 'نامعلوم',
      isPardakht: json['is_pardakht'] ?? 0,
      sabtid: json['sabtid'] ?? 'نامعلوم',
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['bename'] = bename;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['marhoom_name'] = marhoomName;
    _data['is_pardakht'] = isPardakht;
    _data['sabtid'] = sabtid;
    return _data;
  }
}
