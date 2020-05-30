import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_unsplash_gallery/repo/api/api_helper.dart';
import 'package:flutter_unsplash_gallery/repo/api/models/image_model.dart';
import 'package:flutter_unsplash_gallery/utils/constants.dart';


class PicturePage extends StatefulWidget {
  final String title;
  final ImageModel item;

  PicturePage({Key key, this.title, this.item}) : super(key: key);

  @override
  _PicturePage createState() => _PicturePage(item: item);
}

class _PicturePage extends State<PicturePage> {
  final ImageModel item;

  _PicturePage({Key key, this.item});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => CircularProgressIndicator(),
      fit: BoxFit.contain,
      imageUrl: item.url,
    );
  }
}
