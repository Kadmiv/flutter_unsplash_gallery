import 'dart:convert';

import 'package:flutter_unsplash_gallery/repo/api/api_helper.dart';
import 'package:flutter_unsplash_gallery/repo/api/api_listener.dart';
import 'package:flutter_unsplash_gallery/repo/api/models/image_model.dart';
import 'package:flutter_unsplash_gallery/repo/api/parsers/image_model_parser.dart';
import 'package:flutter_unsplash_gallery/ui/base/base_presenter.dart';
import 'package:flutter_unsplash_gallery/ui/search_picture_page/search_list_view.dart';
import 'package:flutter_unsplash_gallery/ui/widgets/search_widget.dart';
import 'package:flutter_unsplash_gallery/utils/di/factory.dart';
import 'package:flutter_unsplash_gallery/utils/utils.dart';
import 'package:http/src/response.dart';

class SearchListPresenter extends BasePresenter<SearchListView>
    implements ApiListener, SearchWidgetListener {
  final _apiHelper = getIt.get<ApiHelper>();
  final _imageModelParser = getIt.get<ImageModelParser>();

  int _page = 0;
  String _query = "";

  @override
  void onConnectionError() {
    mView.showConnectionError();
  }

  @override
  void onLoadingError() {
    mView.showLoadingError();
  }

  @override
  onReceiveDataList(Response response) {}

  @override
  void loadMore() {
  Future<bool> future=  isHaveConnection();
  future.then((value){
    if(value){
      _apiHelper.searchPageByQuery(_query, _page++, this);
    }else{
      mView.showConnectionError();
    }
  });
  }

  @override
  void onReceiveSearchDataList(Response response) {
    try {
      final parsed = json.decode(response.body).cast<String, dynamic>();
      final itemsCount = parsed["total"];
      mView.setAllItemsCount(itemsCount);

      mView.showEmptyDataView(itemsCount < 1);
    } on Exception catch (e) {
      print(e);
    }

    var items = _imageModelParser.parseModelsFromSearchList(response.body);
    if (_page == 0) {
      mView.initListView(items);
      return;
    }

    mView.updateListView(items);
  }

  @override
  void onChanged(value) {
    _page = 0;
  }

  @override
  void onSubmitted(value) {
    _query = value;
    Future<bool> future=  isHaveConnection();
    future.then((value){
      if(value){
        mView.showLoadingView();
        _apiHelper.searchPageByQuery(_query, _page, this);
      }else{
        mView.showConnectionError();
      }
    });
  }

  Function tryAgain() {

    Future<bool> future=  isHaveConnection();
    future.then((value){
      if(value){
        onSubmitted(_query);
      }else{
        mView.showConnectionError();
      }
    });
  }
}
