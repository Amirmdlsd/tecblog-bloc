import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tecblog/di/di.dart';
import 'package:tecblog/main.dart';
import 'package:tecblog/utils/api_exception.dart';
import 'package:tecblog/utils/auth_manager.dart';
import 'package:tecblog/utils/dio.dart';

abstract class IAthenticatioDatasource {
  Future<void> registerEmail(String email);
  Future<String> verifyCode(String email, String code);
}

class AthenicationremoteDatesource extends IAthenticatioDatasource {
  final Dio _dio = locator.get();
  final Dio dioService = DioService.postDio;

  @override
  Future<void> registerEmail(String email) async {
    try {
      var response = await _dio.post('Techblog/api/register/action.php',
          data: FormData.fromMap({
            'email': email,
            'command': 'register',
          }));
      AuthManager.saveId(response.data['user_id']);
      debugPrint("user id =${response.data['user_id']}");
      debugPrint("user id =${response.data['response']}");
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception("خطا نامشخص");
    }
  }

  @override
  Future<String> verifyCode(String email, String code) async {
    FormData map = FormData.fromMap({
      'email': email,
      'user_id': AuthManager.readUserId(),
      'code': code,
      'command': 'verify'
    });
    String message = "";
    try {
      var response =
          await _dio.post('Techblog/api/register/action.php', data: map);
      //
      switch (response.data["response"]) {
        case "verified":
          AuthManager.saveToken(response.data['token']);
          message = "با موفقیت ثبت نام شدید";
          break;
        case "incorrect_code":
          message = "کدتایید اشتباه است";
          throw Exception(message);

        case "expired":
          message = "کدتایید منقضی شده است";
          throw Exception(message);
      }

      return message;
    } on DioException catch (e) {
      throw ApiException(message: e.toString(), code: e.response!.statusCode!);
    } catch (e) {
      throw ApiException(message: e.toString(), code: 0);
    }
  }
}
