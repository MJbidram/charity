abstract class FurtherInfoEvent {}

class GetFurtherInfoEvent extends FurtherInfoEvent {}

class CreatOrderEvent extends FurtherInfoEvent {
  CreatOrderEvent(this.name, this.marasem, this.type, this.tarh);
  String name;
  int marasem;
  int type;
  int tarh;
}
