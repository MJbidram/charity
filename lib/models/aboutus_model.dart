class AboutUsModel {
  String id;
  String? logo;
  String? website;
  String? phone;
  String? about;
  String? fullname;
  String? shortname;

  AboutUsModel(
      {required this.id,
      this.logo,
      this.website,
      this.phone,
      this.about,
      this.fullname,
      this.shortname});

  factory AboutUsModel.fromJsonMap(Map<String, dynamic> jsonObject) {
    return AboutUsModel(
      id: jsonObject['id'].toString(),
      logo: jsonObject['logo'],
      website: jsonObject['website'],
      phone: jsonObject['phone'],
      about: jsonObject['about'],
      fullname: jsonObject['fullname'],
      shortname: jsonObject['shortname'],
    );
  }
}
