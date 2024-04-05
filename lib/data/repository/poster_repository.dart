import 'package:dartz/dartz.dart';
import 'package:tecblog/data/datasource/poster_datasource.dart';
import 'package:tecblog/data/model/poster_model.dart';
import 'package:tecblog/di/di.dart';

abstract class IPosterRepository {
  Future<Either<String,PosterModel>> getPoster();
}

class PosterRepository extends IPosterRepository {
  final IPosterDatasource _datasource = locator.get();
  @override
  Future<Either<String,PosterModel>> getPoster() async {
    try {
      final response = await _datasource.getPoster();
      return right(response);
    } on Exception catch (e) {
      return left(e.toString());
    }
  }
}
