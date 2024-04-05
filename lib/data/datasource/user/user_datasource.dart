import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tecblog/data/model/top_podcast_model.dart';
import 'package:tecblog/data/model/user_model.dart';
import 'package:tecblog/di/di.dart';
import 'package:tecblog/utils/auth_manager.dart';

abstract class IUserDatasource {
  Future<UserModel> getUserInfo();
  Future<void> updateUserInfo(String name, String image);
  Future<List<TopPodcastModel>> getFavoritePodcast();
}

class UserRemoteDatasource extends IUserDatasource {
  final Dio _dio = locator.get();

  @override
  Future<UserModel> getUserInfo() async {
    try {
      var response = await _dio.get('Techblog/api/user/',
          queryParameters: {
            'command': "info",
            "user_id": AuthManager.readUserId()
          },
          options:
              Options(headers: {"Authorization": AuthManager.readToken()}));

      return UserModel.fromjson(response.data['response']);
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateUserInfo(String name, String image) async {
    try {
      Map<String, dynamic> map = {
        'name': name,
        'image': await MultipartFile.fromFile(image),
        'user_id': AuthManager.readUserId().toString()
      };
      var response = await _dio.post('Techblog/api/user/',
          queryParameters: {'command': 'update'},
          data: FormData.fromMap(map),
          options: Options(
              headers: {"Authorization": AuthManager.readToken().toString()}));
      debugPrint(response.data['response'].toString());
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<TopPodcastModel>> getFavoritePodcast() async {
    try {
      Response response = await _dio.get('Techblog/api/podcast/get.php',
          queryParameters: {
            'user_id': AuthManager.readUserId(),
            'command': 'favorites'
          });

      return response.data
          .map<TopPodcastModel>((json) => TopPodcastModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception("خطا");
    }
  }
}
