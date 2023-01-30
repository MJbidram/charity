abstract class ProfileEditEvent {}

class LoadDetailsProfileEvent extends ProfileEditEvent {}

class SetEditProfileEvent extends ProfileEditEvent {
  String username;
  String phone;
  String email;
  String address;
  // String password;
  // String paswordConfirm;

  SetEditProfileEvent({
    required this.username,
    required this.phone,
    required this.email,
    required this.address,
  });
}
