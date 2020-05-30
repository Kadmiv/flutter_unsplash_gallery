class ImageModel {
  var id = "";
  var url = "";
  var description = "";
  var userName = "";

  ImageModel();

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'url': url,
        'description': description,
        'userName': userName,
      };

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    var answer = ImageModel();

    answer.id = json['id'];
    answer.url = json['url'];
    answer.description = json['description'];
    answer.userName = json['userName'];

    return answer;
  }

  factory ImageModel.fromUnsplashJson(Map<String, dynamic> json) {
    var answer = ImageModel();

    answer.id = json['id'];
    answer.description = json['alt_description'];

    var links = json['links'];
    answer.url = links['download'];

    var user = json['user'];
    answer.userName = user['name'];

    return answer;
  }

}
