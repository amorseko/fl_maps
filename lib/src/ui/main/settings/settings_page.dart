import 'dart:async';
import 'dart:convert';
import 'package:fl_maps/src/model/member_model.dart';
import 'package:fl_maps/src/ui/main/settings/ganti_password.dart';
import 'package:fl_maps/src/ui/main/settings/ganti_profile.dart';
import 'package:fl_maps/src/ui/pre_login.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/utility/Sharedpreferences.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  String _name, id_user;
  bool _isLoading=true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();


    _initView();
  }
  Widget _bgHeader(BuildContext context){
    return new Container(
      child: Image.asset(
        'assets/images/settings.png',
        width: MediaQuery.of(context).size.width/2,
      ),
      alignment: FractionalOffset.topCenter,
      decoration: BoxDecoration(color: Colors.transparent),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        title: TextWidget(txt: "Settings", color: colorTitle()),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: ProgressDialog(
        inAsyncCall: _isLoading,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Padding(
              padding:  new EdgeInsets.only(top: 20.0, left: 20, right: 10),
              child: Column(
                children: <Widget>[
                  _bgHeader(context),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 100,
                            width: 400,
                            child: Material(
                              elevation: 4.0,
                              shape: CircleBorder(),
                              color: primaryColor,
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(8),
                                child: Container(
                                  padding: EdgeInsets.all(22),
                                  child: Center(
                                    child: TextWidget(
                                      txtSize: 30,
                                      txt: _name != null ? _name.substring(0, 1) : "",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            child: Column(
                              crossAxisAlignment : CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _name != null ? _name.trim() : "",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 20, color: primaryColor),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:10),
                    child: new Divider(
                      color: Colors.black38,
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      ListTile(
                        title: Text("Ganti Password",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        leading: new Image.asset(
                          "assets/icons/icons_resetpassword.png",
                          fit: BoxFit.cover, width: 40,),
                        onTap: () =>
                        {
                          routeToWidget(context, new ResetPasswordPage())

                        },
                      ),
                      ListTile(
                        title: Text("Ganti Profile",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        leading: new Image.asset(
                          "assets/icons/icon_profile.png",
                          fit: BoxFit.cover, width: 40,),
                        onTap: () =>
                        {
                          routeToWidget(context, new GantiProfilePage())

                        },
                      ),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: new Divider(
                      color: Colors.black38,
                    ),
                  )
                ],
              ),
            )
          ],
        ),

      ),
    );
  }
  _initView() {
    SharedPreferencesHelper.getDoLogin().then((member){
      final memberModels = MemberModels.fromJson(json.decode(member));
      setState(() {
        _name = memberModels.data.name;
        id_user = memberModels.data.id;
        _isLoading = false;
      });
    });
  }

}