import 'package:dio/dio.dart';
import 'package:tecblog/data/model/article_model.dart';
import 'package:tecblog/di/di.dart';

abstract class IHomeArticleDatasource {
  Future<List<ArticleModel>> getTopVisitedList();
}

class HomeArticleRemoteDatasource extends IHomeArticleDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<ArticleModel>> getTopVisitedList() async {
    try {
      var response = await _dio.get("Techblog/api/home/?command=index");
      return response.data["top_visited"]
          .map<ArticleModel>((json) => ArticleModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception("خطا در برقراری ارتباط");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
