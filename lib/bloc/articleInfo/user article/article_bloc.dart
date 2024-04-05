import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tecblog/bloc/articleInfo/user%20article/article_event.dart';
import 'package:tecblog/bloc/articleInfo/user%20article/article_state.dart';
import 'package:tecblog/data/repository/new_article_repository.dart';
import 'package:tecblog/di/di.dart';

class UserArticleBloc extends Bloc<ArticleEvent, UserArticleState> {
  final INewArticleRepository repository = locator.get();
  UserArticleBloc() : super(ArticleInitState()) {
    on<StoreArticleEvent>((event, emit) async {
      emit(UserArticleLoadingState());
      var res = await repository.sendArticle(
          event.title, event.content, event.catId, event.image);
      emit(ArticleResponseState(res));
    });
    on<GetMyArticleEvent>((event, emit) async {
      emit(UserArticleLoadingState());
      await repository
          .getMyArticle()
          .then((value) => emit(GetMyAricleResponseState(value)));
    });
  }
}
