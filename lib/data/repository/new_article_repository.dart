import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tecblog/data/datasource/article/article_datasource.dart';
import 'package:tecblog/data/model/article_model.dart';
import 'package:tecblog/di/di.dart';
import 'package:tecblog/utils/api_exception.dart';

abstract class INewArticleRepository {
  Future<Either<String, List<ArticleModel>>> getNewArticle();
  Future<Either<String, List<ArticleModel>>> getNewArticleWithCatId(
      String catId);
  Future<Either<String, String>> sendArticle(
      String title, String content, String catId, String image);
  Future<Either<String, List<ArticleModel>>> getMyArticle();
}

class NewArticleRepository extends INewArticleRepository {
  final INewArticleDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<ArticleModel>>> getNewArticle() async {
    try {
      var response = await _datasource.getNewArticle();
      return right(response);
    } on Exception catch (e) {
      return left(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<String, List<ArticleModel>>> getNewArticleWithCatId(
      String catId) async {
    try {
      var response = await _datasource.getNewArticleWithCatId(catId);
      return right(response);
    } on Exception catch (e) {
      return left(e.toString());
    } catch (e) {
      return left("خطا");
    }
  }

  @override
  Future<Either<String, String>> sendArticle(
      String title, String content, String catId, String image) async {
    try {
      var response =
          await _datasource.sendArticle(title, content, catId, image);
      return right("با موفقیت ثبت شد");
    } on Exception catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ArticleModel>>> getMyArticle() async {
    try {
      var response = await _datasource.getMyArticke();
      return right(response);
    } on Exception catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }
}
