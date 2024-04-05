import 'package:dio/dio.dart';
import 'package:tecblog/data/model/top_podcast_model.dart';
import 'package:tecblog/di/di.dart';

abstract class INewPodcastDatesource {
  Future<List<TopPodcastModel>> getNewPodcastList();
}

class NewPodcsatRemoteDatasource extends INewPodcastDatesource {
  final Dio _dio = locator.get();

  @override
  Future<List<TopPodcastModel>> getNewPodcastList() async {
    try {
      Map<String, dynamic> queryParam = {"command": "new", "user_id": "1"};
      var response = await _dio.get('Techblog/api/podcast/get.php',
          queryParameters: queryParam);
      return response.data
          .map<TopPodcastModel>((json) => TopPodcastModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception("خطا در برقراری ارتباط");
    }
  }
}
