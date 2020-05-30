import 'package:flutter_unsplash_gallery/repo/api/api_helper.dart';
import 'package:flutter_unsplash_gallery/repo/api/models/image_model.dart';
import 'package:flutter_unsplash_gallery/ui/base/base_presenter.dart';
import 'package:flutter_unsplash_gallery/ui/picture_list_screen/picture_list_view.dart';
import 'package:flutter_unsplash_gallery/utils/di/factory.dart';

class PictureListPresenter extends BasePresenter<PictureListView> {
  final _apiHelper = getIt.get<ApiHelper>();

  onItemClicked(ImageModel item) {
    mView.openImagePage(item);
  }

  Future<List<ImageModel>> loadPictureList() async {
    return _apiHelper.loadPictureList();
  }
}
