import 'package:flutter_unsplash_gallery/repo/api/api_helper.dart';
import 'package:flutter_unsplash_gallery/repo/api/parsers/image_model_parser.dart';
import 'package:flutter_unsplash_gallery/ui/picture_list_page/picture_list_presenter.dart';
import 'package:flutter_unsplash_gallery/ui/search_picture_page/search_list_presenter.dart';
import 'package:get_it/get_it.dart';

import '../constants.dart';

GetIt getIt = GetIt.instance;

void getServices() {
  getIt.registerSingleton<ApiHelper>(ApiHelper.withToken(baseUrl, token));
  getIt.registerFactory<PictureListPresenter>(() => PictureListPresenter());
  getIt.registerFactory<SearchListPresenter>(() => SearchListPresenter());
  getIt.registerFactory<ImageModelParser>(() => ImageModelParser());
}
