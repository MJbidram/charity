class ApiException implements Exception {
  String? message;
  int? code;

  ApiException(this.code, this.message);
}

class RegisterErrorModel {
  String? name;
  String? phone;
  String? password;
  // String? email;
  String? unknow;

  RegisterErrorModel(
    this.name,
    this.phone,
    // this.email,
    this.password,
    this.unknow,
  );

  // factory RegisterErrorModel.fromeJsonMap(Map<String, dynamic> jsonObject) {
  //   return RegisterErrorModel(
  //     // jsonObject['name'] ?? '',
  //     jsonObject['phone'][0],
  //     jsonObject['email'][0],
  //     // jsonObject['password'] ?? '',
  //   );
  // }
}

class LoginErrorModel {
  String? phone;
  String? password;
  String? message;
  String? unknow;

  LoginErrorModel(
    this.phone,
    this.password,
    this.unknow,
    this.message,
  );
}
