import 'package:flutter_unsplash_gallery/repo/api/parsers/image_model_parser.dart';

import 'api_listener.dart';
import 'models/image_model.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  String _baseUrl = "";

  String _token = "";

  set token(String token) {
    _token = token;
  }

  ApiHelper(String baseUrl) {
    _baseUrl = baseUrl;
  }

  ApiHelper.withToken(String baseUrl, String token) {
    _baseUrl = baseUrl;
    _token = token;
  }

  loadPictureFromPage(int page, ApiListener listener) async {
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    //https://api.unsplash.com/photos?page=3&client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0
    var requestUrl = "${_baseUrl}photos?client_id=${_token}&page=${page}";

    await http.get(requestUrl, headers: headers).then((response) {
      print(response);
      var _status = response.statusCode;
      var _body = response.body;
      if (_status == 200)
        listener.onReceiveDataList(response);
      else
        listener.onLoadingError();
    }).catchError((error) {
      var _status = 0;
      var _body = error.toString();

      listener.onConnectionError();
    }).timeout(Duration(seconds: 30));
  }

  searchPageByQuery(String query, int page, ApiListener listener) async {
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    //    https://api.unsplash.com/search/photos?page=1&query=office
    var requestUrl =
        "${_baseUrl}search/photos?client_id=${_token}&page=${page}&query=${query}";

    await http.get(requestUrl, headers: headers).then((response) {
      print(response);
      var _status = response.statusCode;
      var _body = response.body;
      if (_status == 200)
        listener.onReceiveSearchDataList(response);
      else
        listener.onLoadingError();
    }).catchError((error) {
      var _status = 0;
      var _body = error.toString();

      listener.onConnectionError();
    }).timeout(Duration(seconds: 30));
  }
}
