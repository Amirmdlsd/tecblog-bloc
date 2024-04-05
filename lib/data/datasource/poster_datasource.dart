import 'package:dio/dio.dart';
import 'package:tecblog/data/model/poster_model.dart';
import 'package:tecblog/di/di.dart';

abstract class IPosterDatasource {
  Future<PosterModel> getPoster();
}

class HomePosterRemoteDatasource extends IPosterDatasource {
  final Dio _dio = locator.get();
  @override
  Future<PosterModel> getPoster() async {
    try {
      var response = await _dio.get("Techblog/api/home/?command=index");
      PosterModel poster = PosterModel.fromJson(response.data['poster']);
      return poster;
    } on DioException catch (e) {
      throw Exception("خطا در برقراری ارتباط");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
