import 'package:dartz/dartz.dart';
import 'package:tecblog/data/datasource/tag/tags_datasource.dart';
import 'package:tecblog/data/model/tags_model.dart';
import 'package:tecblog/di/di.dart';

abstract class ITagsRepository {
  Future<Either<String, List<TagsModel>>> getTags();
}

class TagsRepository extends ITagsRepository {
  final TagsDatasource datasource = locator.get();

  @override
  Future<Either<String, List<TagsModel>>> getTags() async {
    try {
      var response = await datasource.getTags();

      return right(response);
    } on Exception catch (e) {
      return left(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
