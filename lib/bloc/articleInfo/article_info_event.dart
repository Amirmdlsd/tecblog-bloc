abstract class ArticleINfoEvent {}

class ArticleInfoSendRequestEvent extends ArticleINfoEvent {
  String id;

  ArticleInfoSendRequestEvent(this.id);
}
