class ProfileModel {
  int id;
  String name;
  String phone;
  String? email;
  String? address;
  int? charity;

  ProfileModel(
      this.id, this.name, this.phone, this.email, this.address, this.charity);

  factory ProfileModel.fromJsonMap(Map<String, dynamic> jsonObject) {
    return ProfileModel(
        jsonObject['id'],
        jsonObject['name'],
        jsonObject['phone'],
        jsonObject['email'],
        jsonObject['address'],
        jsonObject['charity']);
  }
}

class ProfileUpdateModel {
  String message;
  String status;
  ProfileUpdateModel(this.message, this.status);
  factory ProfileUpdateModel.fromJsonMap(Map<String, dynamic> jsonObject) {
    return ProfileUpdateModel(
      jsonObject['message'],
      jsonObject['status'],
    );
  }
}
