import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_unsplash_gallery/repo/api/models/image_model.dart';
import 'package:flutter_unsplash_gallery/ui/picture_list_page/picture_list_presenter.dart';
import 'package:flutter_unsplash_gallery/ui/picture_list_page/picture_list_view.dart';
import 'package:flutter_unsplash_gallery/ui/search_picture_page/search_list_page.dart';
import 'package:flutter_unsplash_gallery/ui/single_picture_page/picture_page.dart';
import 'package:flutter_unsplash_gallery/ui/widgets/connection_error_widget.dart';
import 'package:flutter_unsplash_gallery/ui/widgets/image_item_widget.dart';
import 'package:flutter_unsplash_gallery/utils/di/factory.dart';
import 'package:flutter_unsplash_gallery/utils/utils.dart';
import 'package:loadmore/loadmore.dart';

class PictureListPage extends StatefulWidget {
  PictureListPage({Key key}) : super(key: key);

  @override
  _PictureListPage createState() => _PictureListPage();
}

class _PictureListPage extends State<PictureListPage>
    with AutomaticKeepAliveClientMixin
    implements PictureListView {


  @override
  bool get wantKeepAlive => true;

  Widget pageView;
  var maxItemsCount = 2341260;

  Map<String, ImageModel> _dataItems = new Map<String, ImageModel>();
  final _presenter = getIt.get<PictureListPresenter>();

  @override
  void initState() {
    super.initState();
    _presenter.attachView(this);
    _presenter.loadPictureList();
  }



  @override
  Widget build(BuildContext context) {
    pageView = createPageView(_dataItems);

    return Center(
      child: pageView,
    );
  }

  @override
  void openImagePage(ImageModel item) {
    Route route = MaterialPageRoute(
        builder: (context) => PicturePage(
              item: item,
            ));
    Navigator.push(context, route);
  }

  @override
  void showLoadingView() {
    setState(() {
      pageView = Center(child: CircularProgressIndicator());
    });
  }

  @override
  initListView(List<ImageModel> value) {
    setState(() {
      _dataItems.addAll(toImageMap(value));

      pageView = createPageView(_dataItems);
    });
  }

  @override
  updateListView(List<ImageModel> value) {
    setState(() {
      _dataItems.addAll(toImageMap(value));
    });
  }

  @override
  Function showLoadingError() {
    setState(() {
      pageView = Center(child: Text("Loading error"));
    });
  }

  Map<String, ImageModel> toImageMap(List<ImageModel> value) {
    Map<String, ImageModel> imageMap = Map<String, ImageModel>();
    value.forEach((element) {
      imageMap[element.id] = element;
    });
    return imageMap;
  }

//  AlertDialog dialog;
  @override
  void showConnectionError() {
    showConnectionErrorDialog(context, _presenter.tryAgain);
  }

  Future<bool> _loadMore() async {
    _presenter.loadMore();
    await Future.delayed(Duration(seconds: 0, milliseconds: 3000));
    return isHaveConnection();
  }

  Future<void> _refresh() async {
    _presenter.loadPictureList();
    await Future.delayed(Duration(seconds: 0, milliseconds: 3000));
  }

  createListItemCard(ImageModel item) {
    return new GestureDetector(
      onTap: () => _presenter.onItemClicked(item),
      child: ImageItemWidget(item),
    );
  }

  Widget createPageView(Map<String, ImageModel> dataItems) {
    var keys = _dataItems.keys.toList();

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        child: RefreshIndicator(
          child: LoadMore(
            isFinish: keys.length >= maxItemsCount-1,
            onLoadMore: _loadMore,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return createListItemCard(_dataItems[keys[index]]);
              },
              itemCount: keys.length,
            ),
            whenEmptyLoad: false,
            delegate: DefaultLoadMoreDelegate(),
            textBuilder: DefaultLoadMoreTextBuilder.english,
          ),
          onRefresh: _refresh,
        ),
      ),
    );
  }
}
