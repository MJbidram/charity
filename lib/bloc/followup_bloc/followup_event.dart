abstract class FollowUpEvent {}

class FollowUpLoadEvent extends FollowUpEvent {}

class FollowUpDeletEvent extends FollowUpEvent {
  final String id;
  FollowUpDeletEvent(this.id);
}

class FollowUpUpdateEvent extends FollowUpEvent {}
