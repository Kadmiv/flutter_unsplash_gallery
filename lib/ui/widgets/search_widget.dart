import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchWidgetListener {
  void onChanged(value) {}

  void onSubmitted(value) {}
}

class SearchWidget extends StatefulWidget {
  SearchWidgetListener listener;

  SearchWidget(this.listener, {Key key}) : super(key: key);

  @override
  _SearchWidget createState() => _SearchWidget(listener);
}

class _SearchWidget extends State<SearchWidget> {
  TextEditingController _searchController = TextEditingController();

  SearchWidgetListener listener;

  _SearchWidget(this.listener);

  bool clearIconVisibility = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        listener.onChanged(value);
        setState(() {
          clearIconVisibility = value.isNotEmpty;
        });
      },
      onSubmitted: (value) {
        listener.onSubmitted(value);
      },
      controller: _searchController,
      decoration: InputDecoration(
          labelText: "Search",
          hintText: "Text your request here...",
          prefixIcon: Icon(Icons.search),
          suffixIcon: crateClearButton(),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    );
  }

  crateClearButton() {
    return Visibility(
      child: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          clearSearchQuery();
        },
      ),
      visible: clearIconVisibility,
    );
  }

  void clearSearchQuery() {
    setState(() {
      _searchController.text = "";
      clearIconVisibility = false;
    });
  }
}
