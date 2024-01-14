import 'package:bloc/bloc.dart';

import '../../database_helper/database_provider.dart';
import '../../model/user.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginUserEvent>((event, emit) async {
      if (event is LoginUserEvent) {
        try {
          final List<User> users =
              await DatabaseProvider.getUsersByEmail(event.email);

          if (users.isEmpty) {
            emit(LoginErrorState("User not found"));
          } else {
            final User user = users.first;

            if (user.password == event.password) {
              emit(LoginSuccessState(user));
            } else {
              emit(LoginErrorState("Incorrect password"));
            }
          }
        } catch (e) {
          emit(LoginErrorState("Login failed: $e"));
        }
      }
    });
  }
}
