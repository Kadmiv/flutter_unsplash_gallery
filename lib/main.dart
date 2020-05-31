
import 'package:flutter/material.dart';
import 'package:flutter_unsplash_gallery/ui/main_page/main_page.dart';
import 'package:flutter_unsplash_gallery/utils/di/factory.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      initialRoute: addressMainPage,
      routes: appRoutes,
    );
  }
}

final String addressSplashPage = "/";
final String addressMainPage = "/main";


final appRoutes = {
  addressMainPage: (context) => MainPage(),
};
