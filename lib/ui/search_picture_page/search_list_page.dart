

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unsplash_gallery/repo/api/models/image_model.dart';
import 'package:flutter_unsplash_gallery/ui/search_picture_page/search_list_presenter.dart';
import 'package:flutter_unsplash_gallery/ui/search_picture_page/search_list_view.dart';
import 'package:flutter_unsplash_gallery/ui/widgets/connection_error_widget.dart';
import 'package:flutter_unsplash_gallery/utils/di/factory.dart';
import 'package:loadmore/loadmore.dart';

class SearchListPage extends StatefulWidget {
  SearchListPage({Key key}) : super(key: key);
  @override
  _SearchListPage createState() => _SearchListPage();
}

class _SearchListPage extends State<SearchListPage>  with AutomaticKeepAliveClientMixin
    implements SearchListView  {
  Map<String, ImageModel> _dataItems = new Map<String, ImageModel>();

  final _presenter = getIt.get<SearchListPresenter>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _presenter.attachView(this);
    _presenter.loadPictureList();
  }

  Widget pageView;

  @override
  Widget build(BuildContext context) {
    pageView = createPageView(_dataItems);

    return Center(
      child: pageView,
    );
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

  @override
  void showConnectionError() {
    setState(() {
      pageView = ConnectionErrorWidget(_presenter.loadPictureList);
    });
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    _presenter.loadMore();
    await Future.delayed(Duration(seconds: 0, milliseconds: 3000));
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 3000));
//    list.clear();
//    load();
  }

  Widget _imagePlaceHolder() {
    return Container(
      height: 200,
      child: SizedBox(
        height: 300,
      ),
    );
  }

  createListItemCard(ImageModel item) {
    return  Container(
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              children: <Widget>[
                Hero(
                  tag: "image" + item.id,
                  child: new AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Container(
                      height: 300,
                      child: CachedNetworkImage(
                        imageUrl: item.url,
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    item.userName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.description),
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
//        margin: EdgeInsets.all(10),
        ),
    );
  }

  Widget createPageView(Map<String, ImageModel> dataItems) {
    var keys = _dataItems.keys.toList();

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        child: RefreshIndicator(
          child: LoadMore(
            isFinish: keys.length >= 2341260,
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