import 'package:dio/dio.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tecblog/data/datasource/poster_datasource.dart';
import 'package:tecblog/data/model/podcast_file.dart';
import 'package:tecblog/data/model/top_podcast_model.dart';
import 'package:tecblog/di/di.dart';
import 'package:tecblog/utils/auth_manager.dart';

abstract class IPodcastFileDataource {
  Future<List<PodcastFileModel>> getPodcastFile(
      String podcatsId, ConcatenatingAudioSource playList);

  Future<void> storeFavoritePodcast(String podcastId);
  Future<void> deleteFavoritePodcast(String podcastId);
}

class PodcastFileRemoteDatasource extends IPodcastFileDataource {
  final Dio _dio = locator.get();
  @override
  Future<List<PodcastFileModel>> getPodcastFile(
      String podcatsId, ConcatenatingAudioSource playList) async {
    try {
      var response = await _dio.get(
        'Techblog/api/podcast/get.php',
        queryParameters: {'command': 'get_files', 'podcats_id': podcatsId},
      );
      for (var e in response.data['files']) {
        playList
            .add(AudioSource.uri(Uri.parse(PodcastFileModel.fromJson(e).file)));
      }
      return response.data['files'].map<PodcastFileModel>((json) {
        return PodcastFileModel.fromJson(json);
      }).toList();
    } on DioException catch (e) {
      throw Exception("خطایی رخ داده است");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> storeFavoritePodcast(String podcastId) async {
    try {
      Response response = await _dio.post('Techblog/api/podcast/post.php',
          data: FormData.fromMap({
            'podcast_id': podcastId,
            'user_id': AuthManager.readUserId(),
            'command': 'store_favorite'
          }),
          options:
              Options(headers: {'Authorization': AuthManager.readToken()}));
    } on DioException catch (e) {
      throw Exception('خطایی رخ داده است');
    } catch (e) {
      throw Exception('خطایی رخ داده است');
    }
  }

  @override
  Future<void> deleteFavoritePodcast(String podcastId) async {
    try {
      Response response = await _dio.post('Techblog/api/podcast/post.php',
          data: FormData.fromMap({
            'fav_id': podcastId,
            'user_id': AuthManager.readUserId(),
            'command': 'delete_favorite'
          }),
          options:
              Options(headers: {'Authorization': AuthManager.readToken()}));
    } on DioException catch (e) {
      throw Exception('خطایی رخ داده است');
    } catch (e) {
      throw Exception('خطایی رخ داده است');
    }
  }
}
