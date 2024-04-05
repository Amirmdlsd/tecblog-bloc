import 'package:dartz/dartz.dart';
import 'package:tecblog/data/datasource/tags_datasource.dart';
import 'package:tecblog/data/model/tags_model.dart';
import 'package:tecblog/di/di.dart';

abstract class TagsRepositoryMain {
  Future<Either<String, List<TagsModel>>> getTagsList();
}

class TagsRepositoryRemote extends TagsRepositoryMain {
  final ITagsDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<TagsModel>>> getTagsList() async {
    try {
      var response = await _datasource.getTagsList();
      return right(response);
    } on Exception catch (e) {
      return left(e.toString());
    }
  }
}
