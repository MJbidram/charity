abstract class DamandEvent {}

class GetDamandFirstTypeEvent extends DamandEvent {}

class GetDamandSecandTypeEvent extends DamandEvent {
  String firstType;
  GetDamandSecandTypeEvent(this.firstType);
}

class SendDamandEvent extends DamandEvent {
  String type;
  String? details;
  String address;

  SendDamandEvent(
      {required this.type, required this.address, required this.details});
}
