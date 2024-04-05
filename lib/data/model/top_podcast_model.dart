class TopPodcastModel {
  String? id;
  String? title;
  String? poster;
  String? catName;
  String? author;
  String? view;
  String? status;
  String? createdAt;
  String? favId;

  TopPodcastModel(this.id, this.title, this.poster, this.catName, this.author,
      this.view, this.status, this.createdAt,
      {this.favId});

  factory TopPodcastModel.fromJson(Map<String, dynamic> json) {
    return TopPodcastModel(
        json['id'],
        json['title'],
        "https://techblog.sasansafari.com/${json['poster']}",
        json['cat_name'],
        json['author'],
        json['view'],
        json['status'],
        json['created_at'],
        favId: json['fav_id']);
  }
}
