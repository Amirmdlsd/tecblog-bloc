import 'package:just_audio/just_audio.dart';

abstract class PodcastFileEvent {}

class PodcastFileFetchDataEvent extends PodcastFileEvent {
  final String podcastId;
  final ConcatenatingAudioSource playList;

  PodcastFileFetchDataEvent(this.podcastId, this.playList);
}
