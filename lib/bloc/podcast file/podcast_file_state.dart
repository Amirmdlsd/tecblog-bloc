import 'package:dartz/dartz.dart';
import 'package:tecblog/data/model/podcast_file.dart';

abstract class PodcastFileState {}

class PodcastFileInitState extends PodcastFileState {}

class PodcastFileLoadingState extends PodcastFileState {}

class PodcastFileResponseState extends PodcastFileState {
  Either<String, List<PodcastFileModel>> podcastFile;
  PodcastFileResponseState(this.podcastFile);
}
