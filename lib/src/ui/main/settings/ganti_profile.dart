import 'dart:convert';

import 'package:fl_maps/src/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/model/member_model.dart';
//import 'package:fl_maps/src/utility/colors.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/utility/sharedpreferences.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:fl_maps/src/bloc/bloc_change_profile.dart';

class GantiProfilePage extends StatefulWidget {
  @override
  _GantiProfilePage createState() => _GantiProfilePage();
}

class _GantiProfilePage extends State<GantiProfilePage> {
  final _Name = TextEditingController();
  final _NoHp = TextEditingController();
  final _NoTelepon = TextEditingController();
  String _idUser, _name, _noHp, _noTlp;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isLoading = false;

  void initState() {
    super.initState();


    _initView();
  }

  _initView() {
    SharedPreferencesHelper.getDoLogin().then((member){
      final memberModels = MemberModels.fromJson(json.decode(member));
      setState(() {
        _name = memberModels.data.name;
        _noHp = memberModels.data.no_hp;
        _noTlp = memberModels.data.no_telp;
        _NoHp.text = _noHp;
        _NoTelepon.text = _noTlp;
        _Name.text = _name;
        _isLoading = false;
      });
    });
  }

  Widget _bgHeader(BuildContext context) {
    return new Container(
      child: Image.asset(
        'assets/images/change_password.png',
        width: MediaQuery.of(context).size.width,
      ),
      alignment: FractionalOffset.topCenter,
      decoration: BoxDecoration(color: Colors.transparent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        title: TextWidget(
            txt: "Ganti Profile",
            color: colorTitle()),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: ProgressDialog(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _bgHeader(context),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: TextFormField(
                    controller: _Name ,
                    decoration: InputDecoration(
                        labelText: "Nama",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: TextFormField(
                    controller: _NoHp,
                    decoration: InputDecoration(
                        labelText: "No.Hp",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: TextFormField(
                    controller: _NoTelepon,
                    decoration: InputDecoration(
                      labelText: "No.Telepon",
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ButtonTheme(
                      child: new RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: TextWidget(
                          color: Colors.white,
                          txt: "Ubah",
                          txtSize: 14.0,
                        ),
                        elevation: 4.0,
                        color: primaryColor,
                        splashColor: Colors.redAccent,
                        onPressed: () {
                          _changePassword();
                        },
                      ),
                      height: 50.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        inAsyncCall: _isLoading,
      ),
    );
  }

  _changePassword() {
    setState(() {
      _isLoading = false;
    });

    if (_Name.text != "" ||
        _NoHp.text != "" ||
        _NoTelepon.text != "") {
            print("not empty");
            SharedPreferencesHelper.getDoLogin().then((onValue) {
              final memberModels = MemberModels.fromJson(json.decode(onValue));
              setState(() {
                _idUser = memberModels.data.id;
              });
              _isLoading = true;
              var request = {
                  "nama": _Name.text,
                  "no_hp" : _NoHp.text,
                  "no_telp": _NoTelepon.text,
                  "id_user": _idUser};
              bloc.actChangeProfile(request, (status, message) => {
                setState(() {
                  _isLoading = false;
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text(
                      message.toString(),
                    ),
                    duration: Duration(seconds: 2),
                  ));
                })
//
              });
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "Password tidak sama",
        ),
        duration: Duration(seconds: 2),
      ));
//      showErrorMessage(context, "Password tidak sama", false);
    }
  }



//  _verifyChangePassword(bool status, String message) {
//    print(message);
//    print(status);
//    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
//    setState(() {
//      _newPasswordController.clear();
//      _reNewPassController.clear();
//      _isLoading = false;
//    });
//  }
}