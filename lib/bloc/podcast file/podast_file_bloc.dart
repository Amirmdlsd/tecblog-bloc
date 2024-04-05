import 'package:bloc/bloc.dart';
import 'package:tecblog/bloc/podcast%20file/podcast_file_event.dart';
import 'package:tecblog/bloc/podcast%20file/podcast_file_state.dart';
import 'package:tecblog/data/repository/podcast/single_podcast_file_repository.dart';
import 'package:tecblog/di/di.dart';

class PodcastFileBloc extends Bloc<PodcastFileEvent, PodcastFileState> {
  final IPodcastFileRepository repository = locator.get();
  PodcastFileBloc() : super(PodcastFileInitState()) {
    on<PodcastFileFetchDataEvent>((event, emit) async {
      emit(PodcastFileLoadingState());
      await repository
          .getPodcastFile(event.podcastId, event.playList
          )
          .then((value) => emit(PodcastFileResponseState(value)));
    });
  }
}
