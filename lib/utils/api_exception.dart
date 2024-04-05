class ApiException implements Exception {
  String message;
  int code;
  ApiException({required this.message, required this.code}) {
    if (message == "verified") {
      message = "کاربر ثبت نام شد";
    } else if (message == 'expired') {
      message = "کدفعال سازی منقضی شده است";
    } else if (message == 'incorrect_code') {
      message = "کد فعال سازی اشتباه است";
    }
  }
}
