import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tecblog/bloc/tag/tag_state.dart';
import 'package:tecblog/bloc/tag/tags_event.dart';
import 'package:tecblog/data/repository/tags_repository.dart';
import 'package:tecblog/di/di.dart';

class TagsBloc extends Bloc<TagsFetchListEvent, TagsState> {
  final TagsRepositoryMain repository = locator.get();
  TagsBloc() : super(TagsInitState()) {
    on<TagsFetchListEvent>((event, emit) async {
      emit(TagsLoadingState());
      await repository
          .getTagsList()
          .then((value) => emit(TagsResponseState(value)));
    });
  }
}
