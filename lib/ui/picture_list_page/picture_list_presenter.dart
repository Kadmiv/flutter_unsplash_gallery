import 'package:connectivity/connectivity.dart';
import 'package:flutter_unsplash_gallery/repo/api/api_helper.dart';
import 'package:flutter_unsplash_gallery/repo/api/api_listener.dart';
import 'package:flutter_unsplash_gallery/repo/api/models/image_model.dart';
import 'package:flutter_unsplash_gallery/repo/api/parsers/image_model_parser.dart';
import 'package:flutter_unsplash_gallery/ui/base/base_presenter.dart';
import 'package:flutter_unsplash_gallery/ui/picture_list_page/picture_list_view.dart';
import 'package:flutter_unsplash_gallery/utils/di/factory.dart';
import 'package:http/src/response.dart';

class PictureListPresenter extends BasePresenter<PictureListView>
    implements ApiListener {
  final _apiHelper = getIt.get<ApiHelper>();
  final _imageModelParser = getIt.get<ImageModelParser>();

  int _page = 0;

  //For try again functionality
  Function _lastFunction;

  onItemClicked(ImageModel item) {
    mView.openImagePage(item);
  }

  void loadPictureList() async {
    _lastFunction = loadPictureList;
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
  onReceiveDataList(Response response) {
    if (_page == 0) {
      mView.initListView(_imageModelParser.parseModelsFromList(response.body));
      return;
    }

    mView.updateListView(_imageModelParser.parseModelsFromList(response.body));
  }

  @override
  void loadMore() {
    print("loadMore");
    _lastFunction = loadMore;
    _apiHelper.loadPictureFromPage(_page++, this);
  }

  @override
  void onReceiveSearchDataList(Response value) {}

  void tryAgain() {
    _lastFunction();
  }
}
