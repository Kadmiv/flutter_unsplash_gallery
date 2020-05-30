import 'package:flutter_unsplash_gallery/repo/api/parsers/image_model_parser.dart';

import 'models/image_model.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  String _baseUrl = "";

  String _token = "";

  set token(String token) {
    _token = token;
  }

  var _imageModelParser = ImageModelParser();

  ApiHelper(String baseUrl) {
    _baseUrl = baseUrl;
  }

  ApiHelper.withToken(String baseUrl, String token) {
    _baseUrl = baseUrl;
    _token = token;
  }

  Future<List<ImageModel>> loadPictureList() async {
    final http.Response response = await http.get(
      "${_baseUrl}?client_id=${_token}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(response);
    return _imageModelParser.parseModels(response.body);
  }
}
