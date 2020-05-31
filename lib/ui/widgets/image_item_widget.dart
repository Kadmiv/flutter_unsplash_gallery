import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unsplash_gallery/repo/api/models/image_model.dart';

class ImageItemWidget extends StatelessWidget {
  ImageModel item;

  ImageItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  aspectRatio: 5 / 2,
                  child: Container(
                    child: CachedNetworkImage(
                      imageUrl: item.url,
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
}
