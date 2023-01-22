class FactorsModle {
  int id;
  int amunt;
  String? createdAt;
  String? updatedAt;
  String sabtId;
  String? resNum;
  int isPardakht;
  String title;

  FactorsModle({
    required this.id,
    required this.amunt,
    this.createdAt,
    this.updatedAt,
    required this.sabtId,
    this.resNum,
    required this.isPardakht,
    required this.title,
  });

  factory FactorsModle.fromJsonMap(Map<String, dynamic> jsonObject) {
    return FactorsModle(
      id: jsonObject['id'],
      amunt: jsonObject['amount'],
      createdAt: jsonObject['created_at'],
      updatedAt: jsonObject['updated_at'],
      sabtId: jsonObject['sabtid'],
      resNum: jsonObject['ResNum'],
      isPardakht: jsonObject['is_pardakht'],
      title: jsonObject['title'],
    );
  }
}
