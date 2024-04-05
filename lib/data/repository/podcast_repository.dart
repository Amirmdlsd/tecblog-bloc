import 'package:dartz/dartz.dart';
import 'package:tecblog/data/datasource/home_article_datasource.dart';
import 'package:tecblog/data/datasource/home_podcast_datasource.dart';
import 'package:tecblog/data/model/article_model.dart';
import 'package:tecblog/data/model/top_podcast_model.dart';
import 'package:tecblog/di/di.dart';

abstract class IHomePodcastRepository {
  Future<Either<String, List<TopPodcastModel>>> getTopPodcastList();
}

class HomePodcastRepository extends IHomePodcastRepository {
  final IHomePodcastDatasource _datasource = locator.get();
  
  @override
  Future<Either<String, List<TopPodcastModel>>> getTopPodcastList()async {
 try {
      var response = await _datasource.getTopPodcastList();
      return right(response);
    } on Exception catch (e) {
      return left(e.toString());
    }
  }
 

}
