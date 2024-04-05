abstract class NewArticleEvent {}

class NewArticleSendRequestEvent extends NewArticleEvent {}

class NewArticleSendRequestForCatIdEvent extends NewArticleEvent {
  String id;
  NewArticleSendRequestForCatIdEvent(this.id);
}
