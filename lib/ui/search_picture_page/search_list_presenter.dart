import 'package:flutter_unsplash_gallery/repo/api/api_helper.dart';
import 'package:flutter_unsplash_gallery/repo/api/api_listener.dart';
import 'package:flutter_unsplash_gallery/repo/api/models/image_model.dart';
import 'package:flutter_unsplash_gallery/repo/api/parsers/image_model_parser.dart';
import 'package:flutter_unsplash_gallery/ui/base/base_presenter.dart';
import 'package:flutter_unsplash_gallery/ui/search_picture_page/search_list_view.dart';
import 'package:flutter_unsplash_gallery/utils/di/factory.dart';
import 'package:http/src/response.dart';

class SearchListPresenter extends BasePresenter<SearchListView>
    implements ApiListener {
  final _apiHelper = getIt.get<ApiHelper>();
  final _imageModelParser = getIt.get<ImageModelParser>();

  int _page = 0;

  void loadPictureList() async {
    mView.showLoadingView();
    _apiHelper.loadPictureFromPage(_page, this);
  }

  @override
  void onConnectionError() {
    mView.showConnectionError();
  }

  @override
  void onLoadingError() {
    mView.showLoadingError();
  }

  @override
  onReceiveImageList(Response response) {
    if (_page == 0) {
      mView.initListView(_imageModelParser.parseModels(response.body));
      return;
    }

    mView.updateListView(_imageModelParser.parseModels(response.body));
  }

  @override
  void loadMore() {
    // TODO: implement loadMore
    print("loadMore");
    _apiHelper.loadPictureFromPage(_page++, this);
  }
}
