class PosterModel {
  String? id;
  String? title;
  String? image;
  PosterModel(this.id, this.title, this.image);

  factory PosterModel.fromJson(Map<String, dynamic> json) {
    return PosterModel(json["id"], json["title"],
    
    "https://techblog.sasansafari.com"+ json["image"]);
  }
}
