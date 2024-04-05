import 'package:dartz/dartz.dart';
import 'package:tecblog/data/datasource/podcast/podcast_list_screen.dart';
import 'package:tecblog/data/model/top_podcast_model.dart';
import 'package:tecblog/di/di.dart';

abstract class INewPodcastRepository {
  Future<Either<String, List<TopPodcastModel>>> getNewPodcastList();
}

class NewPodcastRepository extends INewPodcastRepository {
  final INewPodcastDatesource _datesource = locator.get();
  @override
  Future<Either<String, List<TopPodcastModel>>> getNewPodcastList() async {
    try {
      var response = await _datesource.getNewPodcastList();
      return right(response);
    } on Exception catch (e) {
      return left(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
