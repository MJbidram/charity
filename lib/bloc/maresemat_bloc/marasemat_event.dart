abstract class MarasematEvent {}

class GetMarasematEvent extends MarasematEvent {}

class filterOnMarasemat extends MarasematEvent {
  String search;
  filterOnMarasemat(this.search);
}
