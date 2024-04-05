import 'package:dartz/dartz.dart';
import 'package:tecblog/data/model/article_info.dart';
import 'package:tecblog/data/model/article_model.dart';
import 'package:tecblog/data/model/tags_model.dart';

abstract class ArticleINfoState {}

class ArticeInfoInitState extends ArticleINfoState {}

class ArticleInfoLoadingState extends ArticleINfoState {}

class ArticleInfoRequestSuccess extends ArticleINfoState {
  Either<String, ArticleInfoModel> articleInfo;
  Either<String, List<TagsModel>> tags;
  Either<String, List<ArticleModel>> related;

  ArticleInfoRequestSuccess(this.articleInfo,this.tags,this.related);
}
