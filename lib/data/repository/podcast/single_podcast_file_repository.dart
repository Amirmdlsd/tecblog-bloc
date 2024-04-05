import 'package:dartz/dartz.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tecblog/data/datasource/podcast/single_podcast_datasource.dart';
import 'package:tecblog/data/model/podcast_file.dart';
import 'package:tecblog/di/di.dart';

abstract class IPodcastFileRepository {
  Future<Either<String, List<PodcastFileModel>>> getPodcastFile(
      String podcastId, ConcatenatingAudioSource playList);

  Future<Either<String, String>> storeFavoritePodcast(String podcastId);
  Future<Either<String, String>> deleteFavoritePodcast(String podcastId);
}

class PodcastFileRepository extends IPodcastFileRepository {
  final IPodcastFileDataource dataource = locator.get();

  @override
  Future<Either<String, List<PodcastFileModel>>> getPodcastFile(
      String podcastId, ConcatenatingAudioSource playList) async {
    try {
      var response = await dataource.getPodcastFile(podcastId, playList);

      return right(response);
    } on Exception catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteFavoritePodcast(String podcastId) async {
    try {
      var response = await dataource.storeFavoritePodcast(podcastId);

      return right('از علاقه مندی حذف شد');
    } on Exception catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> storeFavoritePodcast(String podcastId) async {
    try {
      var response = await dataource.deleteFavoritePodcast(podcastId);

      return right('به علاقه مندی اضافه شد');
    } on Exception catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }
}
