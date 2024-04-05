import 'package:dartz/dartz.dart';
import 'package:tecblog/data/model/tags_model.dart';

abstract class TagsState {}

class TagsInitState extends TagsState {}

class TagsLoadingState extends TagsState {}

class TagsResponseState extends TagsState {
  Either<String, List<TagsModel>> tagsList;

  TagsResponseState(this.tagsList);
}
