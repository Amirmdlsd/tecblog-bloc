import 'package:bloc/bloc.dart';
import 'package:tecblog/bloc/articleInfo/article_info_event.dart';
import 'package:tecblog/bloc/articleInfo/article_info_state.dart';
import 'package:tecblog/bloc/newArticle/new_article_state.dart';
import 'package:tecblog/data/repository/article_info_repository.dart';
import 'package:tecblog/di/di.dart';

class ArticleInfoBloc extends Bloc<ArticleINfoEvent, ArticleINfoState> {
  final IArticleInfoRepository repository = locator.get();
  ArticleInfoBloc() : super(ArticeInfoInitState()) {
    on<ArticleInfoSendRequestEvent>((event, emit) async {
      emit(ArticleInfoLoadingState());
      var response = await repository.getArticleInfo(event.id);
      var tags = await repository.getTags(event.id);
      var related = await repository.getRelatedList(event.id);
      emit(ArticleInfoRequestSuccess(response,tags,related));
    });
  }
}
