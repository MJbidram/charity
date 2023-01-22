abstract class FactorsEvent {}

class FactorRequestListEvent extends FactorsEvent {
  String? token;
  FactorRequestListEvent(this.token);
}
