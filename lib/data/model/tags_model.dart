class TagsModel {
  String? id;
  String? title;
  TagsModel(this.id, this.title);

  factory TagsModel.fromjson(Map<String, dynamic> json) {
    return TagsModel(json["id"], json["title"]);
  }
}
