class MicroAppModel {
  String? title;
  String? image;
  String? link;

  MicroAppModel({this.title, this.image, this.link});

  MicroAppModel.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
    if (json["link"] is String) {
      link = json["link"];
    }
  }
}
