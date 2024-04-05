class PodcastFileModel {
  String id;
  String podcastId;
  String file;
  String title;
  String length;

  PodcastFileModel(this.id, this.podcastId, this.file, this.title, this.length);
  factory PodcastFileModel.fromJson(Map<String, dynamic> json) {
    return PodcastFileModel(
        json['id'],
        json['podcast_id'],
        "https://techblog.sasansafari.com/${json['file']}" ,
        json['title'],
        json['length']);
  }
}
