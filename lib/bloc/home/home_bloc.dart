import 'package:bloc/bloc.dart';
import 'package:tecblog/bloc/home/home_event.dart';
import 'package:tecblog/bloc/home/home_state.dart';

import 'package:tecblog/data/repository/home_article_repository.dart';
import 'package:tecblog/data/repository/podcast_repository.dart';
import 'package:tecblog/data/repository/poster_repository.dart';
import 'package:tecblog/data/repository/tag/main_tags_repository.dart';
import 'package:tecblog/data/repository/tags_repository.dart';
import 'package:tecblog/di/di.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHomeArticleRepository _repository = locator.get();
  final IHomePodcastRepository _podcastRepository = locator.get();
  final TagsRepositoryMain tagsRepository = locator.get();
  final IPosterRepository posterRepository = locator.get();
  HomeBloc() : super(HomeInitState()) {
    on<HomeSendRequestEvent>((event, emit) async {
      emit(HomeLoadingState());
      final topVisited = await _repository.getTopVisitedList();
      final topPodcast = await _podcastRepository.getTopPodcastList();
      var tags = await tagsRepository.getTagsList();
      var poster = await posterRepository.getPoster();
      emit(HomeRequestSuccessState(topVisited, topPodcast, tags, poster));
    });
  }
}
