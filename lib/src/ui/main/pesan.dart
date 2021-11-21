import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fl_maps/src/model/member_model.dart';
import 'package:fl_maps/src/utility/Sharedpreferences.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:flutter/services.dart';
import 'package:fl_maps/src/bloc/bloc_pesan.dart';
import 'package:fl_maps/src/model/default_model.dart';

class PesanPage extends StatefulWidget {
  @override
  _PesanPage createState() => _PesanPage();
}

class _PesanPage extends State<PesanPage> {
  bool _isAsync = true;
  String _fullname, _id,username;

  final _Pesan = TextEditingController();
  @override
  void initState() {

    SharedPreferencesHelper.getDoLogin().then((member) async {
      print("data member : $member");
      final memberModels = MemberModels.fromJson(json.decode(member));
      setState(() {
        _fullname = memberModels.data.name;
        username = memberModels.data.username;
        _id = memberModels.data.id;
      });
    });

    _isAsync = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        title: TextWidget(txt: "Pesan", color: colorTitle()),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: ProgressDialog(
        inAsyncCall: _isAsync,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 0.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.text,
                      controller: _Pesan,
                      decoration: InputDecoration(
                        labelText: "Pesan",
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
                            txt: "SAVE",
                            txtSize: 14.0,
                          ),
                          elevation: 4.0,
                          color: primaryColor,
                          splashColor: hintColor,
                          onPressed: () {
                            saveData();

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
      ),
    );
  }

  saveData() async {
    setState(() {
      _isAsync = true;
    });

    var formData = FormData.fromMap({
      'pesan': _Pesan.text,
      'user' : username,
    });

    bloc.doPesanBloc(formData,(callback){
      DefaultModel model = callback;

      print(model);

      setState(() {
        _isAsync = false;
        print(model.status);
        showErrorMessage(context, model.message, model.error);
      });

    });

  }

  void showErrorMessage(BuildContext context, String message, bool status) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
            height: MediaQuery.of(context).size.width / 2.5,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      new BorderRadius.all(const Radius.circular(30.0))),
                  child: Container(
                      width: MediaQuery.of(context).size.width * (3 / 2),
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  message,
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (message == "success") {
                                      clearfield();
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, "/maps_page", (_) => false);
//                                      Navigator.of(context).pushReplacement(new MaterialPageRoute(settings: const RouteSettings(name: '/list_bantuan'), builder: (context) => new ListBantuanPage()));
//                                      routeToWidget(context, MainPage())
//                                          .then((value) {
//                                        setPotrait();
//                                      });

                                    } else {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Container(
                                      width:
                                      MediaQuery.of(context).size.width / 2,
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: new BorderRadius.all(
                                              const Radius.circular(30.0)),
                                          color: primaryColor),
                                      child: Text(
                                        "OK",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          );
        });
  }

  void clearfield() {
    _Pesan.text = "";
  }
}