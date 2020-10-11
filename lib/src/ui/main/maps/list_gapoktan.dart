import 'dart:async';

import 'package:fl_maps/src/utility/utils.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/model/model_gapoktan.dart';
import 'package:fl_maps/src/bloc/bloc_gapoktan.dart';
import 'package:fl_maps/src/bloc/request/params_maps.dart';
import 'package:fl_maps/src/ui/main/maps/page_maps.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences_settings/shared_preferences_settings.dart';
import 'package:fl_maps/src/utility/Sharedpreferences.dart';
class GapoktanPage extends StatefulWidget {
  @override
  _GapoktakPage createState() => _GapoktakPage();
}

class _GapoktakPage extends State<GapoktanPage> {

  bool _isLoading = true;
//  bool _checkedValue = false;
  List<String> ressChecked = [];

  var tmpArray = [];

  var userStatus = List<bool>();
  SharedPreferences sharedPrefs;

  List GapoktanData = List<ListGapoktanData>();
  String _currText = '';
  int sCount = 0;

  List<ListGapoktanData> dataGapoktan = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initView();
//    restore();

  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            brightness: Brightness.light,
            automaticallyImplyLeading: false,
            title: Text("Layer Map", style: TextStyle(color: Colors.white)),
            centerTitle: true,
            backgroundColor: primaryColor),
        body: ProgressDialog(
          inAsyncCall: _isLoading,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
              future: getGapoktanData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (snapshot.data == null) {
                  return Container(child: Center(child: Text("Loading...")));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(snapshot.data[index].gapoktan),
                        trailing: Checkbox(
                          value:  userStatus[index],
                            onChanged: (bool val) {
                              setState(() {
                                userStatus[index] = !userStatus[index];

                                if(val) {
                                  _currText = snapshot.data[index].id_gapoktan;
                                  _AddToList(_currText,val);
                                  print(_currText);
                                } else {
                                  _currText = snapshot.data[index].id_gapoktan;
                                  _AddToList(_currText,val);
                                }
                              });
                            }),
                      );
                    }
                  );
                }
              }
            ),
          ),
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 50.0),
          child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                child: Icon(
                    Icons.save,
                    color: Colors.white
                ),
                backgroundColor: primaryColor,
                onPressed: (){
                  String ParamsCheck;
                  if(ressChecked.length > 0) {
//                    ParamsCheck = ressChecked.join(',');
                    bool CheckValue = sharedPrefs.containsKey('listgapoktan');

                    if(CheckValue) {
                      ParamsCheck = sharedPrefs.getString('listgapoktan');
                    }
                  } else {
                    bool CheckValue = sharedPrefs.containsKey('listgapoktan');

                    if(CheckValue) {
                      ParamsCheck = sharedPrefs.getString('listgapoktan');
                    } else {
                      ParamsCheck = "";
                    }
                  }

                  print("ini datanya : $ParamsCheck");

                  routeToWidget(context, MapsPage(dataLayer: ParamsCheck,)).then((value) {
                    setPotrait();
                  });
//                routeToWidget(context, FormPengajuanPage());
                },
              )
          ),
        )
    );
  }

  _AddToList(String checkedValue, bool val) async {
    sharedPrefs = await SharedPreferences.getInstance();
    bool CheckValue = sharedPrefs.containsKey('listgapoktan');
    if(val) {
//      bool CheckValue = sharedPrefs.containsKey('listgapoktan');

      ressChecked.add(checkedValue);
      sharedPrefs.setBool(checkedValue, val);
      String ParamsCheck = ressChecked.join(',');
      sharedPrefs.setString("listgapoktan", ParamsCheck);
//      sharedPrefs.setString(checkedValue, checkedValue);

    } else {
//      ressChecked.remove(checkedValue);

      if(CheckValue) {
        if(sharedPrefs.getString("listgapoktan").contains(",")) {
          List<String> dataArray = sharedPrefs.getString("listgapoktan").split(",");
          dataArray.removeWhere((element) => element == checkedValue);
          ressChecked.removeWhere((element) => element == checkedValue);
          String ParamsCheck = ressChecked.join(',');
          sharedPrefs.setString("listgapoktan", ParamsCheck);
        } else {
          sharedPrefs.remove(checkedValue);
          ressChecked.removeWhere((element) => element == checkedValue);
          String ParamsCheck = ressChecked.join(',');
          sharedPrefs.setString("listgapoktan", ParamsCheck);
        }
      } else {

        sharedPrefs.remove(checkedValue);
        ressChecked.removeWhere((element) => element == checkedValue);
        String ParamsCheck = ressChecked.join(',');
        sharedPrefs.setString("listgapoktan", ParamsCheck);
      }
    }


  }


  Future<List<ListGapoktanData>> getGapoktanData() async{
      reqMapsList params = reqMapsList(
          gapoktan: ""
      );


      await blocGapoktan.getListGapoktanBloc(params.toMap(), (status, error, message, model){

        print(model.status);
        setState(() {
          dataGapoktan = model.data;
//          userStatus.add(false);
          _isLoading=false;

        });
        dataGapoktan = model.data;

      });


    return dataGapoktan;
  }



  initView() async {

    reqMapsList params = reqMapsList(
        gapoktan: ""
    );

    await blocGapoktan.getListGapoktanBloc(params.toMap(), (status,error,message,model) async {
      GetModelGapoktan dataM = model;
      sharedPrefs = await SharedPreferences.getInstance();
//      sharedPrefs.clear();
      for(int i=0; i < dataM.data.length; i++) {
        setState(() {

          userStatus.add((sharedPrefs.getBool(dataM.data[i].id_gapoktan) ?? false));
        });
      }

      if(sharedPrefs.containsKey('listgapoktan')) {
        if(sharedPrefs.getString('listgapoktan').contains(',')) {

          var dataArray =sharedPrefs.getString('listgapoktan').split(",");
          dataArray.forEach((element) {
            ressChecked.add(element);
          });
        } else {
          ressChecked.add(sharedPrefs.getString('listgapoktan'));
        }


      }
      setState(() {
        _isLoading = false;
      });
    });
  }
}
