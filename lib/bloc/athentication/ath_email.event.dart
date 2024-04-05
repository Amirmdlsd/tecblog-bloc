abstract class AthenticationEvent {}

class AthenticatioSendEmailRequest extends AthenticationEvent {
  String email;
  AthenticatioSendEmailRequest(this.email);
}

class AuthVerificationCodeEvent extends AthenticationEvent {
  String email;
  String code;
  AuthVerificationCodeEvent(this.email, this.code);
}
