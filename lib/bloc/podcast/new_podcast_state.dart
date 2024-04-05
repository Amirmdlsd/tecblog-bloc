import 'package:dartz/dartz.dart';
import 'package:tecblog/data/model/top_podcast_model.dart';

abstract class NewPodcastState {}

class NewPodcastInitState extends NewPodcastState {}

class NewPodcastLoadingState extends NewPodcastState {}

class NewPodcastRequestSuccessState extends NewPodcastState {
  Either<String, List<TopPodcastModel>> newPodcastList;
  NewPodcastRequestSuccessState(this.newPodcastList);
}
