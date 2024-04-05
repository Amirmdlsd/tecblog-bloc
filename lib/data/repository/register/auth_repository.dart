import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tecblog/data/datasource/register/athenticatio_datasource.dart';
import 'package:tecblog/di/di.dart';
import 'package:tecblog/utils/api_exception.dart';
import 'package:tecblog/utils/auth_manager.dart';

abstract class IAuthenticatioRepository {
  Future<Either<String, String>> registerEmail(String email);
  Future<Either<String, String>> verifyCode(
      String email, String code);
}

class AuthenticationRepository extends IAuthenticatioRepository {
  final IAthenticatioDatasource datasource = locator.get();

  @override
  Future<Either<String, String>> registerEmail(String email) async {
    try {
      debugPrint(AuthManager.readUserId().toString());
      var response = await datasource.registerEmail(email);

      return right("کد ارسال شد");
    } on Exception catch (e) {
      return left(e.toString());
    } catch (e) {
      throw left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> verifyCode(
      String email, String code) async {
    try {
      var response = await datasource.verifyCode(email, code);

      return right(response);
    } on ApiException catch (e) {
      return left(e.message.toString() ?? "خطا");
    } catch (e) {
      throw left(e.toString() ?? "خطا");
    }
  }
}
