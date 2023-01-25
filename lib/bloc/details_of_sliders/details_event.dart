abstract class DetailsEvent {}

class LoadPooyshEvent extends DetailsEvent {
  int id;
  LoadPooyshEvent(this.id);
}

class LoadProjectEvent extends DetailsEvent {
  int id;
  LoadProjectEvent(this.id);
}
