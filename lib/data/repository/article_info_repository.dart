import 'package:dartz/dartz.dart';
import 'package:tecblog/data/datasource/article/article_info_datasource.dart';
import 'package:tecblog/data/model/article_info.dart';
import 'package:tecblog/data/model/article_model.dart';
import 'package:tecblog/data/model/tags_model.dart';
import 'package:tecblog/di/di.dart';

abstract class IArticleInfoRepository {
  Future<Either<String, ArticleInfoModel>> getArticleInfo(String id);
  Future<Either<String, List<TagsModel>>> getTags(String id);
  Future<Either<String, List<ArticleModel>>> getRelatedList(String id);
  Future<Either<String, String>> storeFavoriteArticle(String articleId);
  Future<Either<String, String>> deleteFavoriteArticle(String articleId);
}

class ArticleInfoRepostory implements IArticleInfoRepository {
  final IArticleInfoDatasource datasource = locator.get();

  @override
  Future<Either<String, ArticleInfoModel>> getArticleInfo(String id) async {
    try {
      var response = await datasource.getArticleInfo(id);
      return right(response);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TagsModel>>> getTags(String id) async {
    try {
      var response = await datasource.getTags(id);
      return right(response);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ArticleModel>>> getRelatedList(String id) async {
    try {
      var response = await datasource.getRelatedList(id);
      return right(response);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> storeFavoriteArticle(String articleId) async {
    try {
      var response = await datasource.storeFavoriteArticle(articleId);
      return right("ب علاقه مندی ها اضافه شد");
    } on Exception catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteFavoriteArticle(String articleId) async {
    try {
      var response = await datasource.storeFavoriteArticle(articleId);
      return right("از علاقه مندی ها حذف شد");
    } on Exception catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }
}
