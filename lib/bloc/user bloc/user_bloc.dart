import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tecblog/bloc/user%20bloc/user_event.dart';
import 'package:tecblog/bloc/user%20bloc/user_state.dart';
import 'package:tecblog/data/repository/user/user_repository.dart';
import 'package:tecblog/di/di.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final IUserRepository repository = locator.get();
  UserBloc() : super(UserInitState()) {
    on<UserGetInfoEvent>((event, emit) async {
      emit(UserLoadingState());
      await repository
          .getUserInfo()
          .then((value) => emit(UserResponseState(value)));
    });
    on<UserUpdateInfoEvent>((event, emit) async {
      emit(UserLoadingState());

      await repository
          .updateUserInfo(event.name, event.image)
          .then((value) => emit(UserUpdateState(value)));
    });
  }
}
