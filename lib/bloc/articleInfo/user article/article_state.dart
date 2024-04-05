import 'package:dartz/dartz.dart';
import 'package:tecblog/data/model/article_model.dart';

abstract class UserArticleState {}

class ArticleInitState extends UserArticleState {}

class UserArticleLoadingState extends UserArticleState {}

class ArticleResponseState extends UserArticleState {
  Either<String, String> response;
  ArticleResponseState(this.response);
}

class GetMyAricleResponseState extends UserArticleState {
  Either<String, List<ArticleModel>> getMyArticle;
  GetMyAricleResponseState(this.getMyArticle);
}
