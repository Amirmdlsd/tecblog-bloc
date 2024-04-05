import 'package:dartz/dartz.dart';

abstract class AuthenticationState {}

class AuthInitState extends AuthenticationState {}

class AuthLoadingState extends AuthenticationState {}

class AuthRequestSuccessState extends AuthenticationState {
  Either<String, String> emailSuccess;
  AuthRequestSuccessState(this.emailSuccess);
}

class AuthVerifyState extends AuthenticationState {
  Either<String, String> result;
  AuthVerifyState(this.result);
}
