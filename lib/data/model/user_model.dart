class UserModel {
  String id;
  String name;
  String image;
  String email;
  UserModel(this.id, this.name, this.image, this.email);

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
      json['id'],
      json['name'],
      " https://techblog.sasansafari.com/ ${json['image']}",
      json['email'],
    );
  }
}
