import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tecblog/bloc/user%20bloc/user_bloc.dart';
import 'package:tecblog/data/datasource/article/article_datasource.dart';
import 'package:tecblog/data/datasource/article/article_info_datasource.dart';
import 'package:tecblog/data/datasource/home_article_datasource.dart';
import 'package:tecblog/data/datasource/home_podcast_datasource.dart';
import 'package:tecblog/data/datasource/podcast/podcast_list_screen.dart';
import 'package:tecblog/data/datasource/podcast/single_podcast_datasource.dart';
import 'package:tecblog/data/datasource/poster_datasource.dart';
import 'package:tecblog/data/datasource/register/athenticatio_datasource.dart';
import 'package:tecblog/data/datasource/tag/tags_datasource.dart';
import 'package:tecblog/data/datasource/tags_datasource.dart';
import 'package:tecblog/data/repository/article_info_repository.dart';
import 'package:tecblog/data/repository/home_article_repository.dart';
import 'package:tecblog/data/repository/new_article_repository.dart';
import 'package:tecblog/data/repository/podcast/new_podcast_repository.dart';
import 'package:tecblog/data/repository/podcast/single_podcast_file_repository.dart';
import 'package:tecblog/data/repository/podcast_repository.dart';
import 'package:tecblog/data/repository/poster_repository.dart';
import 'package:tecblog/data/repository/register/auth_repository.dart';
import 'package:tecblog/data/repository/tag/main_tags_repository.dart';
import 'package:tecblog/data/repository/tags_repository.dart';
import 'package:tecblog/data/repository/user/user_repository.dart';
import 'package:tecblog/data/datasource/user/user_datasource.dart';

final locator = GetIt.instance;

Future<void> getItInit() async {
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: "https://techblog.sasansafari.com/")));

  //datasource
  locator.registerFactory<IHomeArticleDatasource>(
      () => HomeArticleRemoteDatasource());
  locator.registerFactory<IHomePodcastDatasource>(
      () => HomePodcastRemoteDatasource());
  locator.registerFactory<ITagsDatasource>(() => HomeTagsRemoteDatasource());
  locator
      .registerFactory<IPosterDatasource>(() => HomePosterRemoteDatasource());
  locator.registerFactory<INewArticleDatasource>(
      () => NewArticleRemoteDatasource());
  locator.registerFactory<INewPodcastDatesource>(
      () => NewPodcsatRemoteDatasource());
  locator.registerFactory<IAthenticatioDatasource>(
      () => AthenicationremoteDatesource());
  locator.registerFactory<IArticleInfoDatasource>(
      () => IArticleInfoRemoteDatasource());

  locator.registerFactory<TagsDatasource>(() => TagsRemoteDatasource());
  locator.registerFactory<IUserDatasource>(() => UserRemoteDatasource());
  locator.registerFactory<IPodcastFileDataource>(
      () => PodcastFileRemoteDatasource());
  //repository
  locator
      .registerFactory<IHomeArticleRepository>(() => HomeArticleRepository());
  locator
      .registerFactory<IHomePodcastRepository>(() => HomePodcastRepository());
  locator.registerFactory<ITagsRepository>(() => TagsRepository());
  locator.registerFactory<IPosterRepository>(() => PosterRepository());
  locator.registerFactory<INewArticleRepository>(() => NewArticleRepository());
  locator.registerFactory<INewPodcastRepository>(() => NewPodcastRepository());
  locator.registerFactory<IArticleInfoRepository>(() => ArticleInfoRepostory());
  locator.registerFactory<IAuthenticatioRepository>(
      () => AuthenticationRepository());
  locator.registerFactory<TagsRepositoryMain>(() => TagsRepositoryRemote());
  locator.registerFactory<IUserRepository>(() => UserRepository());
  locator
      .registerFactory<IPodcastFileRepository>(() => PodcastFileRepository());

  //bloc

  locator.registerSingleton<UserBloc>(UserBloc());
}
