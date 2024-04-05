import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tecblog/data/model/article_model.dart';
import 'package:tecblog/di/di.dart';
import 'package:tecblog/gen/assets.gen.dart';
import 'package:tecblog/utils/api_exception.dart';
import 'package:tecblog/utils/auth_manager.dart';

abstract class INewArticleDatasource {
  Future<List<ArticleModel>> getNewArticle();
  Future<List<ArticleModel>> getNewArticleWithCatId(String catId);
  Future<void> sendArticle(
      String title, String content, String catId, String image);
  Future<List<ArticleModel>> getMyArticke();
}

class NewArticleRemoteDatasource extends INewArticleDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<ArticleModel>> getNewArticle() async {
    try {
      Map<String, dynamic> quertParam = {
        "command": "new",
        "user_id": AuthManager.readUserId(),
      };
      var response = await _dio.get("Techblog/api/article/get.php",
          queryParameters: quertParam);
      return response.data
          .map<ArticleModel>((json) => ArticleModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception("خطا در برقراری ارتباط");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ArticleModel>> getNewArticleWithCatId(String catId) async {
    try {
      Map<String, dynamic> quertParam = {
        "command": "get_articles_with_cat_id",
        "cat_id": catId,
        "user_id": AuthManager.readUserId(),
      };

      var response = await _dio.get("Techblog/api/article/get.php",
          queryParameters: quertParam);
      return response.data
          .map<ArticleModel>((json) => ArticleModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception("خطا در برقراری ارتیاط");
    } catch (e) {
      throw Exception("اطلاعات وارد شده استباه است");
    }
  }

  @override
  Future<void> sendArticle(
    String title,
    String content,
    String catId,
    String image,
  ) async {
    try {
      File imageFile = File(image);
      var response = await _dio.post("Techblog/api/article/post.php",
          options: Options(headers: {'authorization': AuthManager.readToken()}),
          data: FormData.fromMap({
            'title': title,
            "content": content,
            'cat_id': catId,
            'tag_list': '[]',
            'user_id': AuthManager.readUserId(),
            'image': await MultipartFile.fromFile(imageFile.path),
            'command': 'store'
          }));
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ArticleModel>> getMyArticke() async {
    try {
      var response = await _dio.get('Techblog/api/article/get.php',
          queryParameters: {
            'command': 'published_by_me',
            'user_id': AuthManager.readUserId()
          });
      return response.data
          .map<ArticleModel>((json) => ArticleModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception("خطایی پیش آمده است");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
