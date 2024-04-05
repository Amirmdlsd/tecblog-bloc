import 'package:dio/dio.dart';
import 'package:tecblog/data/model/tags_model.dart';
import 'package:tecblog/di/di.dart';

abstract class TagsDatasource {
  Future<List<TagsModel>> getTags();
}

class TagsRemoteDatasource extends TagsDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<TagsModel>> getTags() async {
    try {
      var response = await _dio.get("Techblog/api/article/get.php",
          queryParameters: {"command": "tas"});
      return response.data.map((json) => TagsModel.fromjson(json)).toist();
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
