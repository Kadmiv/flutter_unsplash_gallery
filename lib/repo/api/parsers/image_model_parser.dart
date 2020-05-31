import 'dart:convert';

import 'package:flutter_unsplash_gallery/repo/api/models/image_model.dart';

class ImageModelParser {
  List<ImageModel> parseModelsFromList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ImageModel>((item) => ImageModel.fromUnsplashJson(item))
        .toList();
  }

  List<ImageModel> parseModelsFromSearchList(String responseBody) {
    print(responseBody);

    final parsed = json.decode(responseBody).cast<String,dynamic>();
    final items = parsed["results"];
    return items
        .map<ImageModel>((item) => ImageModel.fromUnsplashJson(item))
        .toList();
  }
}
