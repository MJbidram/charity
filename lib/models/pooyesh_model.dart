class PooyeshModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final int? amount;
  final String? start;
  final String? end;
  final int typePay;
  final int? persentTamin;

  PooyeshModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      this.amount,
      this.start,
      this.end,
      required this.typePay,
      this.persentTamin});

  factory PooyeshModel.fromJsonMap(Map<String, dynamic> jsonObject) {
    return PooyeshModel(
        id: jsonObject['id'],
        amount: jsonObject['amount'],
        description: jsonObject['description'],
        imageUrl: jsonObject['image'],
        typePay: jsonObject['type_pay'],
        start: jsonObject['start'],
        end: jsonObject['end'],
        title: jsonObject['title'],
        persentTamin: jsonObject['persent_tamin']);
  }
}
