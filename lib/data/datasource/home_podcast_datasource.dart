import 'package:dio/dio.dart';
import 'package:tecblog/data/model/article_model.dart';
import 'package:tecblog/data/model/top_podcast_model.dart';
import 'package:tecblog/di/di.dart';

abstract class IHomePodcastDatasource {
  Future<List<TopPodcastModel>> getTopPodcastList();
}

class HomePodcastRemoteDatasource extends IHomePodcastDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<TopPodcastModel>> getTopPodcastList() async {
    try {
      var response = await _dio.get("Techblog/api/home/?command=index");
      return response.data["top_podcasts"]
          .map<TopPodcastModel>((json) => TopPodcastModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception("خطا در برقراری ارتباط");
    }catch (e) {
      throw Exception(e.toString());
    }
  }
}
