abstract class UserEvent {}

class SaveUserEvent extends UserEvent {
  final String name;
  final String email;
  final String password;

  SaveUserEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class SignInEvent extends UserEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}
