import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_unsplash_gallery/ui/picture_list_page/picture_list_page.dart';
import 'package:flutter_unsplash_gallery/ui/search_picture_page/search_list_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage>  {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(),
          body: TabBarView(
            children: [
              PictureListPage(),
              SearchListPage(),
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list)),
              Tab(icon: Icon(Icons.search)),
            ],
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.blue,
            indicatorColor: Colors.yellow,
          ),
        ),
      ),
    );
  }
}
