import 'package:bloc/bloc.dart';
import 'package:tecblog/bloc/athentication/ath_email.event.dart';
import 'package:tecblog/bloc/athentication/ath_email_state.dart';
import 'package:tecblog/data/repository/register/auth_repository.dart';
import 'package:tecblog/di/di.dart';

class AuthenticatioBloc extends Bloc<AthenticationEvent, AuthenticationState> {
  final IAuthenticatioRepository repository = locator.get();
  AuthenticatioBloc() : super(AuthInitState()) {
    on<AthenticatioSendEmailRequest>((event, emit) async {
      emit(AuthLoadingState());
      var response = await repository.registerEmail(event.email);
      emit(AuthRequestSuccessState(response));
    });
    on<AuthVerificationCodeEvent>((event, emit) async {
      emit(AuthLoadingState());
      var value = await repository.verifyCode(event.email, event.code);
      emit(AuthVerifyState(value));
    });
  }
}
