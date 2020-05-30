import 'package:connectivity/connectivity.dart';
import 'package:flutter_unsplash_gallery/repo/api/api_helper.dart';
import 'package:flutter_unsplash_gallery/repo/api/api_listener.dart';
import 'package:flutter_unsplash_gallery/repo/api/models/image_model.dart';
import 'package:flutter_unsplash_gallery/repo/api/parsers/image_model_parser.dart';
import 'package:flutter_unsplash_gallery/ui/base/base_presenter.dart';
import 'package:flutter_unsplash_gallery/ui/picture_list_screen/picture_list_view.dart';
import 'package:flutter_unsplash_gallery/ui/widgets/image_list_widget.dart';
import 'package:flutter_unsplash_gallery/utils/di/factory.dart';
import 'package:http/src/response.dart';

class PictureListPresenter extends BasePresenter<PictureListView>
    implements ApiListener, ItemListener {
  final _apiHelper = getIt.get<ApiHelper>();
  final _imageModelParser = getIt.get<ImageModelParser>();

  int _page = 0;

  onItemClicked(ImageModel item) {
    mView.openImagePage(item);
  }

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
    print("");
  }
}
