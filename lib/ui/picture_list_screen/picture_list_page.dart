import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_unsplash_gallery/repo/api/models/image_model.dart';
import 'package:flutter_unsplash_gallery/ui/picture_list_screen/picture_list_view.dart';
import 'package:flutter_unsplash_gallery/ui/picture_list_screen/picture_list_presenter.dart';
import 'package:flutter_unsplash_gallery/ui/single_picture_page/picture_page.dart';
import 'package:flutter_unsplash_gallery/ui/widgets/connection_error_widget.dart';
import 'package:flutter_unsplash_gallery/ui/widgets/image_list_widget.dart';
import 'package:flutter_unsplash_gallery/utils/di/factory.dart';


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
    _presenter.loadPictureList();
//    Future<List<ImageModel>> future = _apiHelper.loadPictureList();
//    future.then((value) => {
//          setState(() {
//            _imageModels = toImageMap(value);
//          })
//        });
  }

  Widget pageView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
      body: Center(
        child: pageView,
      ),
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
      ],
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
      _imageModels.addAll(toImageMap(value));
      pageView = ImageList(images: _imageModels, listener: _presenter);
    });
  }

  @override
  updateListView(List<ImageModel> value) {
    setState(() {
      _imageModels.addAll(toImageMap(value));
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
}
