import 'package:dartz/dartz.dart';
import 'package:tecblog/data/datasource/home_article_datasource.dart';
import 'package:tecblog/data/model/article_model.dart';
import 'package:tecblog/di/di.dart';

abstract class IHomeArticleRepository {
  Future<Either<String, List<ArticleModel>>> getTopVisitedList();
}

class HomeArticleRepository extends IHomeArticleRepository {
  final IHomeArticleDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<ArticleModel>>> getTopVisitedList() async {
    try {
      var response = await _datasource.getTopVisitedList();
      return right(response);
    } on Exception catch (e) {
      return left(e.toString());
    }
  }
}
