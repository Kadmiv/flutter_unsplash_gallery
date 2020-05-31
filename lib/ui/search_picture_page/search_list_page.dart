import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unsplash_gallery/repo/api/models/image_model.dart';
import 'package:flutter_unsplash_gallery/ui/search_picture_page/search_list_presenter.dart';
import 'package:flutter_unsplash_gallery/ui/search_picture_page/search_list_view.dart';
import 'package:flutter_unsplash_gallery/ui/widgets/connection_error_widget.dart';
import 'package:flutter_unsplash_gallery/ui/widgets/image_item_widget.dart';
import 'package:flutter_unsplash_gallery/ui/widgets/search_widget.dart';
import 'package:flutter_unsplash_gallery/utils/di/factory.dart';
import 'package:flutter_unsplash_gallery/utils/utils.dart';
import 'package:loadmore/loadmore.dart';

class SearchListPage extends StatefulWidget {
  SearchListPage({Key key}) : super(key: key);

  @override
  _SearchListPage createState() => _SearchListPage();
}

class _SearchListPage extends State<SearchListPage>
    with AutomaticKeepAliveClientMixin
    implements SearchListView {
  @override
  bool get wantKeepAlive => true;

  Map<String, ImageModel> _dataItems = new Map<String, ImageModel>();

  final _presenter = getIt.get<SearchListPresenter>();
  var _maxItemsCount = 2341260;
  bool _notHaveDataTextVisibility = false;

  ScrollController _scrollController = ScrollController();
  Widget infoView = Text("Not have data for request");

  @override
  void initState() {
    super.initState();
    _presenter.attachView(this);
  }

  Widget pageView;

  @override
  Widget build(BuildContext context) {
    pageView = createPageView(_dataItems);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchWidget(_presenter),
        ),
        Expanded(
          child: pageView,
        ),
      ],
    );
  }

  @override
  void showLoadingView() {
    setState(() {
      pageView = Center(child: CircularProgressIndicator());
    });
  }

  @override
  void showEmptyDataView(bool visibility) {
    setState(() {
      _notHaveDataTextVisibility = visibility;
    });
  }

  @override
  initListView(List<ImageModel> value) {
    setState(() {
      _dataItems.clear();
      _dataItems.addAll(toImageMap(value));
      _scrollController.animateTo(
        0,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 200),
      );
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
    setState(() {});
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
    print("onLoadMore");

    _presenter.loadMore();
    await Future.delayed(Duration(seconds: 0, milliseconds: 3000));
    return isHaveConnection();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 3000));
  }

  Widget createPageView(Map<String, ImageModel> dataItems) {
    var keys = _dataItems.keys.toList();

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Stack(
        children: [
          Container(
            child: RefreshIndicator(
              child: LoadMore(
                isFinish: keys.length >= _maxItemsCount - 1,
                onLoadMore: _loadMore,
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return ImageItemWidget(_dataItems[keys[index]]);
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
          Center(
            child: Visibility(
              child: Center(
                child: infoView,
              ),
              visible: _notHaveDataTextVisibility,
            ),
          )
        ],
      ),
    );
  }

  @override
  void setAllItemsCount(itemsCount) {
    setState(() {
      _maxItemsCount = itemsCount;
    });
  }
}
