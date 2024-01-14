import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {}

class UserFailure extends UserState {}

class UserUserExists extends UserState {}

class SignInState extends UserState {}

class SignInSuccess extends UserState {
  final int userId;
  final String userName;

  SignInSuccess(this.userId, this.userName);
}

class SignInError extends UserState {
  final String message;

  SignInError(this.message);
}
