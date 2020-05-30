import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_unsplash_gallery/repo/api/models/image_model.dart';

class ItemListener {
  onItemClicked(ImageModel item) {}

  void loadMore() {}
}

class ImageList extends StatelessWidget {
  final Map<String, ImageModel> images;
  final ItemListener listener;

  ImageList({Key key, this.images, this.listener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var keys = images.keys.toList();


    var listView = GridView.builder(
      itemCount: keys.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) =>
          createListItemCard(images[keys[index]]),
    );

//    var listView = ListView.builder(
//        padding: const EdgeInsets.all(0.0),
//        itemCount: images.length,
//        itemBuilder: (BuildContext context, int index) {
//          var key = keys[index];
//          var _item = images[key];
//          return createListItemCard(_item);
//        });

    return new Padding(
      padding: const EdgeInsets.all(0.0),
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            listener.loadMore();
          }
        },
        child: listView,
      ),
    );
  }

  createListItemCard(ImageModel item) {
    return new GestureDetector(
      onTap: () => listener.onItemClicked(item),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: <Widget>[
            Container(
              width: 140,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: "image" + item.id,
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
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Align(
//                    alignment: Alignment.bottomCenter,
//                    child: Column(
//                      children: [
//                        Text(
//                          item.description,
//                          style: new TextStyle(
//                            color: Colors.black,
//                            fontSize: 18,
//                          ),
//                        ),
//                        Text(
//                          item.userName,
//                          style: new TextStyle(
//                            color: Colors.black,
//                            fontSize: 18,
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
//        margin: EdgeInsets.all(10),
      ),
    );
  }
}
