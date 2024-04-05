import 'package:dartz/dartz.dart';
import 'package:tecblog/bloc/user%20bloc/user_bloc.dart';
import 'package:tecblog/data/model/user_model.dart';

abstract class UserState {}

class UserInitState extends UserState {}

class UserLoadingState extends UserState {}

class UserResponseState extends UserState {
  Either<String, UserModel> userInfo;

  UserResponseState(this.userInfo);
}

class UserUpdateState extends UserState {
  Either<String, String> updateUser;
  UserUpdateState(this.updateUser);
}
