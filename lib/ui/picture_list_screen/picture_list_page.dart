import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_unsplash_gallery/repo/api/api_helper.dart';
import 'package:flutter_unsplash_gallery/repo/api/models/image_model.dart';
import 'package:flutter_unsplash_gallery/ui/picture_list_screen/picture_list_view.dart';
import 'package:flutter_unsplash_gallery/ui/picture_list_screen/picture_list_presenter.dart';
import 'package:flutter_unsplash_gallery/ui/single_picture_page/picture_page.dart';
import 'package:flutter_unsplash_gallery/utils/constants.dart';
import 'package:flutter_unsplash_gallery/utils/di/factory.dart';
import 'package:logger/logger.dart';

var LOG = Logger();

class PictureListPage extends StatefulWidget {
  PictureListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PictureListPage createState() => _PictureListPage();
}

class _PictureListPage extends State<PictureListPage>
    implements PictureListView {
  Map<String, ImageModel> _imageModels = new Map<String, ImageModel>();

  final _presenter = getIt.get<PictureListPresenter>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter.attachView(this);
//    Future<List<ImageModel>> future = _apiHelper.loadPictureList();
//    future.then((value) => {
//          setState(() {
//            _imageModels = toImageMap(value);
//          })
//        });
  }

  @override
  Widget build(BuildContext context) {
    var pageBody = ImageList(images: _imageModels);

    return Scaffold(
      appBar: createAppBar(),
//      drawer: drawer,
      body: getPageView(),
    );
  }

  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("");

  AppBar createAppBar() {
    return AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: appBarTitle,
      actions: <Widget>[
        new IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close);
                this.appBarTitle = TextField(
                  onChanged: (text) {
//                    Future<Map<String, CardModel>> future =
//                    dataBase.findCardsByNamePart(text);
//                    future.then((value) => setState(() {
//                      _userCards = value;
//                    }));
                  },
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                  decoration: new InputDecoration(
                    hintText: "Search...",
                    hintStyle: new TextStyle(color: Colors.white),
                  ),
                );
              } else {
                this.actionIcon = new Icon(Icons.search);
                this.appBarTitle = new Text("");
//                onSearchClose();
              }
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () {},
        ),
      ],
    );
  }

  void openImagePage(ImageModel item) {
    Route route = MaterialPageRoute(
        builder: (context) => PicturePage(
              item: item,
            ));
    Navigator.push(context, route);
  }

  getPageView() {
//    var keys = items.keys.toList();

//    return new Padding(
//      padding: const EdgeInsets.all(0.0),
//      child: ListView.builder(
//          padding: const EdgeInsets.all(0.0),
//          itemCount: items.length,
//          itemBuilder: (BuildContext context, int index) {
//            var key = keys[index];
//            var _item = items[key];
//            return createListItemCard(_item);
//          }),
//    );

    return FutureBuilder<List<ImageModel>>(
      future: _presenter.loadPictureList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? ImageList(
                images: toImageMap(snapshot.data), presenter: _presenter)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Map<String, ImageModel> toImageMap(List<ImageModel> value) {
    Map<String, ImageModel> imageMap = Map<String, ImageModel>();
    value.forEach((element) {
      imageMap[element.id] = element;
    });
    return imageMap;
  }
}

class ImageList extends StatelessWidget {
  final Map<String, ImageModel> images;
  final PictureListPresenter presenter;

  ImageList({Key key, this.images, this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var keys = images.keys.toList();

    return new Padding(
      padding: const EdgeInsets.all(0.0),
      child: ListView.builder(
          padding: const EdgeInsets.all(0.0),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            var key = keys[index];
            var _item = images[key];
            return createListItemCard(_item);
          }),
    );
  }

  createListItemCard(ImageModel item) {
    return new GestureDetector(
      onTap: () => presenter.onItemClicked(item),
      child: Container(
        height: 200,
        child: Hero(
          tag: "image" + item.id,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              children: <Widget>[
                Container(
                  width: 140,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      fit: BoxFit.contain,
                      imageUrl: item.url,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Text(
                          item.description,
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          item.userName,
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
//        margin: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}
