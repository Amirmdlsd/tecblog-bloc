class ArticleModel {
  String? id;
  String? title;
  String? image;
  String? catId;
  String? catName;
  String? author;
  String? view;
  String? status;
  String? createdAt;
  ArticleModel(this.id, this.title, this.image, this.catId, this.catName,
      this.author, this.view, this.status, this.createdAt);

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
        json["id"],
        json["title"],
        // ignore: prefer_interpolation_to_compose_strings
        "https://techblog.sasansafari.com" + json["image"],
        json["cat_id"],
        json["cat_name"],
        json["author"],
        json["view"],
        json["status"],
        json["created_at"]);
  }
}
