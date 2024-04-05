import 'package:dartz/dartz.dart';
import 'package:tecblog/data/model/article_model.dart';

abstract class NewArticleState {}

class NewArticleInitState extends NewArticleState {}

class NewArticleLoadingState extends NewArticleState {}

class NewArticleRequestSuccessState extends NewArticleState {
  Either<String, List<ArticleModel>> newArticle;

  NewArticleRequestSuccessState(
    this.newArticle,
  );
}

class NewArticleRequestSuccessForCatidState extends NewArticleState {
  Either<String, List<ArticleModel>> newArticleWithCatId;

  NewArticleRequestSuccessForCatidState(
    this.newArticleWithCatId,
  );
}
