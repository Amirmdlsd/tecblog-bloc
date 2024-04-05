abstract class ArticleEvent {}

class StoreArticleEvent extends ArticleEvent {
  String title;

  String content;

  String catId;

  String image;

  StoreArticleEvent(this.title, this.content, this.catId, this.image);
}
class GetMyArticleEvent extends ArticleEvent{}
