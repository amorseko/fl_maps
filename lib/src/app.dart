import 'package:fl_maps/src/ui/main/bantuan/list_bantuan.dart';
import 'package:fl_maps/src/ui/main/bantuan/list_bantuan_new.dart';
import 'package:fl_maps/src/ui/main/gapoktan/list_gapoktan.dart';
import 'package:fl_maps/src/ui/main/gapoktan/list_gapoktan_select.dart';
import 'package:fl_maps/src/ui/main/gapoktan/maps_page.dart';
import 'package:fl_maps/src/ui/main/inventory_gapoktan/list_inventory_gapoktan.dart';
import 'package:fl_maps/src/ui/main/kinerja/list_kinerja.dart';
import 'package:fl_maps/src/ui/main/kinerja/list_kinerja_non_bantuan.dart';
import 'package:fl_maps/src/ui/main/kinerja/list_kinerja_only.dart';
import 'package:fl_maps/src/ui/main/komoditi/list_komoditi.dart';
import 'package:fl_maps/src/ui/main/maps/list_gapoktan.dart';
import 'package:fl_maps/src/ui/main/maps/page_maps.dart';
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
        '/list_gapoktan' : (BuildContext context) => new ListGapoktanPage(),
        '/list_bantuan' : (BuildContext context) => new ListBantuanPage(),
        '/list_komoditi' : (BuildContext context) => new ListKomoditiPage(),
        '/gapoktan_page' : (BuildContext context) => new GapoktanPage(),
        '/kinerja_page' : (BuildContext context) => new ListKinerjaPage(),
        '/maps_page' : (BuildContext context) => new MapsPage(),
        '/list_inven_gapoktan' : (BuildContext context) => new ListInvenGapoktanPage(),
        '/maps_page_gapoktan' : (BuildContext context) => new MapsGapoktanPage(),
        '/list_master_gapoktan' : (BuildContext context) => new GapoktanMasterPage(),
        '/list_kinerja_non_bantuan' : (BuildContext context) => new ListKinerjaNonBantuanPage(),
        '/list_kinerja_only' : (BuildContext context) => new ListKinerjaOnlyPage(),
        '/list_bantuan_new' : (BuildContext context) => new ListBantuanNewPage(),
      }
    );
  }
}
