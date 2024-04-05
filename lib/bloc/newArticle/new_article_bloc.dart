import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tecblog/bloc/newArticle/new_article_event.dart';
import 'package:tecblog/bloc/newArticle/new_article_state.dart';
import 'package:tecblog/data/repository/new_article_repository.dart';
import 'package:tecblog/di/di.dart';

class NeweArticleBloc extends Bloc<NewArticleEvent, NewArticleState> {
  final INewArticleRepository repository = locator.get();

  NeweArticleBloc() : super(NewArticleInitState()) {
    on<NewArticleSendRequestEvent>((event, emit) async {
      emit(NewArticleLoadingState());
      var response = await repository.getNewArticle();

      emit(NewArticleRequestSuccessState(
        response,
      ));
    });
    on<NewArticleSendRequestForCatIdEvent>((event, emit) async {
      emit(NewArticleLoadingState());
      await repository
          .getNewArticleWithCatId(event.id)
          .then((value) => emit(NewArticleRequestSuccessForCatidState(value)));
    });
  }
}
