import 'package:bloc/bloc.dart';
import 'package:tecblog/bloc/podcast/new_podcast_event.dart';
import 'package:tecblog/bloc/podcast/new_podcast_state.dart';
import 'package:tecblog/data/repository/podcast/new_podcast_repository.dart';
import 'package:tecblog/di/di.dart';

class NewPodcastBloc extends Bloc<NewPodcastEvent, NewPodcastState> {
  final INewPodcastRepository _repository = locator.get();
  NewPodcastBloc() : super(NewPodcastInitState()) {
    on<NewPodcastSendRequestEvent>((event, emit) async {
      emit(NewPodcastLoadingState());
      var response = await _repository.getNewPodcastList();
      emit(NewPodcastRequestSuccessState(response));
    });
  }
}
