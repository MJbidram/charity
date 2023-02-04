class ProjectModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  final int pishraft;
  final int? typePay;
  final String? slug;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.pishraft,
    required this.slug,
    this.typePay,
  });

  factory ProjectModel.fromJsonMap(Map<String, dynamic> jsonObject) {
    return ProjectModel(
      id: jsonObject['id'],
      description: jsonObject['description'] ?? 'null',
      imageUrl: jsonObject['image_head'],
      typePay: jsonObject['type_pay'],
      pishraft: jsonObject['pishraft'],
      slug: jsonObject['slug'] ?? 'null',
      title: jsonObject['title'] ?? 'null',
    );
  }
}
