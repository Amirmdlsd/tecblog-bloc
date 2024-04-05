import 'package:dio/dio.dart';
import 'package:tecblog/data/model/article_info.dart';
import 'package:tecblog/data/model/article_model.dart';
import 'package:tecblog/data/model/tags_model.dart';
import 'package:tecblog/di/di.dart';
import 'package:tecblog/utils/auth_manager.dart';

abstract class IArticleInfoDatasource {
  Future<ArticleInfoModel> getArticleInfo(String id);
  Future<List<TagsModel>> getTags(String id);
  Future<List<ArticleModel>> getRelatedList(String id);
  Future<void> storeFavoriteArticle(String articleId);
  Future<void> deleteFromFavoriteArticle(String articleId);
}

class IArticleInfoRemoteDatasource extends IArticleInfoDatasource {
  final Dio _dio = locator.get();

  @override
  Future<ArticleInfoModel> getArticleInfo(String id) async {
    try {
      Map<String, String> queryParam = {
        "command": "info",
        "id": id,
        "user_id": AuthManager.readUserId()
      };
      var response = await _dio.get("Techblog/api/article/get.php",
          queryParameters: queryParam);
      var json = ArticleInfoModel.fromJson(response.data);
      return json;
    } on DioException catch (e) {
      throw Exception('خطا در برقراری ارتباط');
    }
  }

  @override
  Future<List<TagsModel>> getTags(String id) async {
    try {
      Map<String, String> queryParam = {
        "command": "info",
        "id": id,
        "user_id": AuthManager.readUserId()
      };
      var response = await _dio.get("Techblog/api/article/get.php",
          queryParameters: queryParam);
      return response.data['tags']
          .map<TagsModel>((json) => TagsModel.fromjson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('خطا در برقراری ارتباط');
    }
  }

  @override
  Future<List<ArticleModel>> getRelatedList(String id) async {
    try {
      Map<String, String> queryParam = {
        "command": "info",
        "id": id,
        "user_id": AuthManager.readUserId()
      };
      var response = await _dio.get("Techblog/api/article/get.php",
          queryParameters: queryParam);
      return response.data['related']
          .map<ArticleModel>((json) => ArticleModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('خطا در برقراری ارتباط');
    }
  }

  @override
  Future<void> storeFavoriteArticle(String articleId) async {
    try {
      Response response = await _dio.post(
        'Techblog/api/article/post.php',
        options: Options(headers: {'Authorization': AuthManager.readToken()}),
        data: FormData.fromMap({
          'user_id': AuthManager.readUserId(),
          'command': 'store_favorite',
          'article_id': articleId
        }),
      );
    } on DioException catch (e) {
      throw Exception("خطایی پیش آمده است");
    } catch (e) {
      throw Exception("خطایی پیش آمده است");
    }
  }

  @override
  Future<void> deleteFromFavoriteArticle(String articleId) async {
    try {
      Response response = await _dio.post(
        'Techblog/api/article/post.php',
        options: Options(headers: {'Authorization': AuthManager.readToken()}),
        data: FormData.fromMap({
          'user_id': AuthManager.readUserId(),
          'command': 'delete_favorite',
          'fav_id': articleId
        }),
      );
    } on DioException catch (e) {
      throw Exception("خطایی پیش آمده است");
    } catch (e) {
      throw Exception("خطایی پیش آمده است");
    }
  }
}
