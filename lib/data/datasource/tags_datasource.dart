import 'package:dio/dio.dart';
import 'package:tecblog/data/model/tags_model.dart';
import 'package:tecblog/di/di.dart';

abstract class ITagsDatasource {
  Future<List<TagsModel>> getTagsList();
}

class HomeTagsRemoteDatasource extends ITagsDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<TagsModel>> getTagsList() async {
    try {
      var response = await _dio.get("Techblog/api/home/?command=index");
      return response.data["tags"]
          .map<TagsModel>((json) => TagsModel.fromjson(json))
          .toList();
      
    } on DioException catch (e) {
      throw Exception("خطا در برقراری ارتباط");
    }catch (e) {
      throw Exception(e.toString());
    }
  }
}
