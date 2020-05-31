
import 'package:flutter/material.dart';
import 'package:flutter_unsplash_gallery/ui/main_page/main_page.dart';
import 'package:flutter_unsplash_gallery/ui/single_picture_page/picture_page.dart';
import 'package:flutter_unsplash_gallery/utils/di/factory.dart';

Future<void> main() async {
   //For DI
  getServices();

  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
//      home: new ListPage(title: 'Lessons'),
//      initialRoute: addressMainPage,
      initialRoute: addressMainPage,
      routes: appRoutes,
//      localizationsDelegates: [
//        // ... app-specific localization delegate[s] here
//        GlobalMaterialLocalizations.delegate,
//        GlobalWidgetsLocalizations.delegate,
//        GlobalCupertinoLocalizations.delegate,
//      ],
//      supportedLocales: [
//        const Locale('en'),
//        // English
//        const Locale('ua'),
//        const Locale('ru'),
//      ],
    );
  }
}

final String addressSplashPage = "/";
final String addressMainPage = "/main";
final String addressPicturePage = "/picture";


final appRoutes = {
  addressMainPage: (context) => MainPage(),
  addressPicturePage: (context) => PicturePage(),
};
