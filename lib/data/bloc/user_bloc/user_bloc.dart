import 'package:bloc/bloc.dart';
import 'package:my_trip_flutter_app/data/bloc/user_bloc/user_bloc_event.dart';
import 'package:my_trip_flutter_app/data/bloc/user_bloc/user_bloc_state.dart';
import '../../database_helper/database_provider.dart';
import '../../model/user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is SaveUserEvent) {
        try {
          final User user = User(
            id: 0,
            name: event.name,
            email: event.email,
            password: event.password,
          );
          await DatabaseProvider.insertUser(user);

          emit(UserSuccess());
        } catch (e) {
          emit(UserFailure());
        }
      }
    });
  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is SaveUserEvent) {
      try {
        final User user = User(
          id: 0,
          name: event.name,
          email: event.email,
          password: event.password,
        );
        await DatabaseProvider.insertUser(user);

        emit(UserSuccess());
      } catch (e) {
        emit(UserFailure());
      }
    }
  }
}
