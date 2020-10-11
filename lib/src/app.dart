import 'package:flutter/material.dart';
import 'package:fl_maps/src/ui/login.dart';
import 'package:fl_maps/src/ui/pre_login.dart';
import 'package:fl_maps/src/ui/splashscreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fl_maps/src/ui/main/main_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily:'Helvetica' ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SplashScreen(),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    routes: <String, WidgetBuilder>{

      '/main_page': (BuildContext context) => new MainPage(),
      '/prelogin_menu': (BuildContext context) => new PreLoginActivity(),
    }
    );
  }
}
