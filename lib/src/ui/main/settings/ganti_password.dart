import 'dart:convert';

import 'package:fl_maps/src/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/bloc/request/do_req_changepass.dart';
import 'package:fl_maps/src/model/member_model.dart';
import 'package:fl_maps/src/utility/sharedpreferences.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:fl_maps/src/bloc/changepass_bloc.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _isHideNewPassword = true;
  final _newPasswordController = TextEditingController();
  bool _isHideReNewPassword = true;
  final _reNewPassController = TextEditingController();
  String _idUser;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isLoading = false;

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
            txt: "Ganti Password",
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
                    controller: _newPasswordController,
                    obscureText: _isHideNewPassword,
                    decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: _isHideNewPassword
                              ? Icon(Icons.vpn_key)
                              : Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              if (_isHideNewPassword) {
                                _isHideNewPassword = false;
                              } else {
                                _isHideNewPassword = true;
                              }
                            });
                          },
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: TextFormField(
                    controller: _reNewPassController,
                    obscureText: _isHideReNewPassword,
                    decoration: InputDecoration(
                        labelText: "Re-Password",
                        suffixIcon: IconButton(
                          icon: _isHideReNewPassword
                              ? Icon(Icons.vpn_key)
                              : Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              if (_isHideReNewPassword) {
                                _isHideReNewPassword = false;
                              } else {
                                _isHideReNewPassword = true;
                              }
                            });
                          },
                        )),
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

    if (_newPasswordController.text != "" ||
        _reNewPassController.text != "") {
      print("not empty");
      if(_newPasswordController.text != _reNewPassController.text)
      {
        setState(() {
          _isLoading = false;
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
              "Password tidak sama",
            ),
            duration: Duration(seconds: 2),
          ));
        });

      }
      else
      {
        SharedPreferencesHelper.getDoLogin().then((onValue) {
          final memberModels = MemberModels.fromJson(json.decode(onValue));
          setState(() {
            _idUser = memberModels.data.id;
          });
          _isLoading = true;
          ReqChangePass request = ReqChangePass(
              password_new: _newPasswordController.text,
              id_user: _idUser);
          bloc.actForgotPass(request.toMap(),
                  (status, message) => {

                setState(() {

                  _isLoading = false;

                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text(
                      message.toString(),
                    ),
                    duration: Duration(seconds: 2),
                  ));

                  if (status == true) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/main_page", (_) => false);
                  } else {
                    Navigator.of(context).pop();
                  }

                })
//          showErrorMessage(context, message, status)
              });
        });
      }

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



  _verifyChangePassword(bool status, String message) {
    print(message);
    print(status);
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
    setState(() {
      _newPasswordController.clear();
      _reNewPassController.clear();
      _isLoading = false;
    });
  }
}