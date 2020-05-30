

import 'dart:convert';

import 'package:flutter_unsplash_gallery/repo/api/models/image_model.dart';

class ImageModelParser{

  List<ImageModel> parseModels(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ImageModel>((json) => ImageModel.fromUnsplashJson(json)).toList();
  }

}