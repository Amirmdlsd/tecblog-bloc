import 'package:dartz/dartz.dart';
import 'package:tecblog/data/model/top_podcast_model.dart';
import 'package:tecblog/data/model/user_model.dart';
import 'package:tecblog/data/datasource/user/user_datasource.dart';
import 'package:tecblog/di/di.dart';

abstract class IUserRepository {
  Future<Either<String, UserModel>> getUserInfo();
  Future<Either<String, String>> updateUserInfo(String name, String image);

  Future<Either<String, List<TopPodcastModel>>> getFavoritePodcast();
}

class UserRepository extends IUserRepository {
  final IUserDatasource _datasource = locator.get();

  @override
  Future<Either<String, UserModel>> getUserInfo() async {
    try {
      var response = await _datasource.getUserInfo();
      return right(response);
    } on Exception catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> updateUserInfo(
      String name, String image) async {
    // TODO: implement updateUserInfo
    try {
      var response = await _datasource.updateUserInfo(name, image);
      return right("با موفقیت ثبت شد");
    } on Exception catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TopPodcastModel>>> getFavoritePodcast() async {
    try {
      var response = await _datasource.getFavoritePodcast();
      return right(response);
    } on Exception catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }
}
