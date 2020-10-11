import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:fl_maps/src/ui/main/bantuan/bantuan.dart';
import 'package:fl_maps/src/ui/main/maps/page_maps.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_maps/src/ui/main/gapoktan/list_gapoktan.dart';
import 'package:fl_maps/src/ui/main/komoditi/komiditi.dart';
import 'package:fl_maps/src/ui/main/komoditi/list_komoditi.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    initView();
    _isLoading = false;
  }

  initView() async{

    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    sharedPrefs.clear();
  }

  Widget _buildCustomCover(Size screenSize) {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        height: screenSize.height / 4,
        width: screenSize.width,
        color: primaryColor,
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/bg_header.png"),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      child: Container(
        height: 100,
        width: 100,
        child: Material(
          elevation: 4.0,
          shape: CircleBorder(),
          color: hintColor,
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.all(22),
              child: Center(
                child: TextWidget(
                  txtSize: 30,
                  txt: "A",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    );

    return Text(
      "ASIAPP",
      style: _nameTextStyle,
    );
  }

  Widget _boxMenu(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            crossAxisCount: 1,
            childAspectRatio: 1.0 / 0.3,
            padding: const EdgeInsets.all(10),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            children: [
              {
                "icon": "assets/icons/icons_peserta.png",
                "title": "BANTUAN",
                "type": "page",
                "page": BantuanPage(),
                "status": true,
                "color": 0xFF74b9ff
              },
              {
                "icon": "assets/icons/icon_maps_bantuan.png",
                "title": "MAP BANTUAN",
                "type": "page",
                "page": MapsPage(),
                "status": true,
                "color": 0xFFFE5661
              },
              {
                "icon": "assets/icons/icons_riwayat.png",
                "title": "GAPOKTAN",
                "type": "page",
                "page": ListGapoktanPage(),
                "status": true,
                "color": 0xFFFF9CA24
              },
              {
                "icon": "assets/icons/icons_komoditi.png",
                "title": "KOMODITI",
                "type": "page",
                "page": ListKomoditiPage(),
                "status": true,
                "color": 0xFF3498DB
              }
            ].where((menu) => menu['status'] == true).map((listMenu) {
              return GestureDetector(
                  onTap: () {
                    if (listMenu['type'] == 'call') {
                      MakeCall(context, listMenu['page']);
                    } else if (listMenu['type'] == 'url') {
//                      _fetchGuideBook();
                    } else {
                      routeToWidget(context, listMenu['page']).then((value) {
                        setPotrait();
                      });
                    }
                  },
                  child: Card(
                      color: Color(listMenu["color"]),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Image.asset(
                              listMenu['icon'],
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height / 15,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              txt: listMenu['title'],
                              txtSize: 12,
                              color: Colors.white,
                            )
                          ],
                        ),
                      )));
            }).toList()));
  }

//  Widget _bgBox(BuildContext context){
//    return new Container(
//      child: Image.asset(
//        'assets/images/bg_box.png',
//        width: MediaQuery.of(context).size.width,
//      ),
//      alignment: FractionalOffset.topCenter,
//      decoration: BoxDecoration(color: Colors.transparent),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ProgressDialog(
          inAsyncCall: _isLoading,
          child: SingleChildScrollView(
              child: Stack(
            children: <Widget>[
              _buildCustomCover(screenSize),
              Positioned(
                  child: Padding(
                padding: const EdgeInsets.only(top: 50.0, right: 10.0),
                child: Align(
                  alignment: FractionalOffset.topRight,
                  child: RawMaterialButton(
                    elevation: 10,
                    shape: new CircleBorder(),
                    child: Image(
                      image: AssetImage("assets/icons/icon_settings.png"),
                      height: 30,
                    ),
                    padding: EdgeInsets.all(5),
                    fillColor: Colors.white,
                    onPressed: () {},
                  ),
                ),
              )),
              SafeArea(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: screenSize.height / 7),
                    _buildProfileImage(),
                    SizedBox(height: 10),
                    _buildFullName(),
                    _boxMenu(context),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          elevation: 5,
                        ))
                  ],
                ),
              ),
            ],
          ))),
    );
  }
}
