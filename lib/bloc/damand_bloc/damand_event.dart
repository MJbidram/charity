abstract class DamandEvent {}

class GetDamandFirstTypeEvent extends DamandEvent {}

class GetDamandSecandTypeEvent extends DamandEvent {
  String firstType;
  GetDamandSecandTypeEvent(this.firstType);
}
