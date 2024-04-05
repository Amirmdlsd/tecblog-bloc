abstract class UserEvent {}

class UserGetInfoEvent extends UserEvent {}

class UserUpdateInfoEvent extends UserEvent {
  String name;
  String image;
  UserUpdateInfoEvent(this.name, this.image);
}
