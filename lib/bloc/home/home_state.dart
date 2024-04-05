import 'package:dartz/dartz.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:tecblog/data/model/article_model.dart';
import 'package:tecblog/data/model/poster_model.dart';
import 'package:tecblog/data/model/tags_model.dart';
import 'package:tecblog/data/model/top_podcast_model.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  Either<String, List<ArticleModel>> articleList;
  Either<String, List<TopPodcastModel>> podcastList;
  Either<String, List<TagsModel>> tagsList;
  Either<String, PosterModel> poster;

  HomeRequestSuccessState(
      this.articleList, this.podcastList, this.tagsList, this.poster);
}
