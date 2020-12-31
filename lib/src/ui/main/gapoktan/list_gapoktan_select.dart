import 'dart:async';
import 'package:fl_maps/src/model/model_master_gapoktan.dart';
import 'package:fl_maps/src/bloc/bloc_list_master_gapoktan.dart';

import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/ui/main/gapoktan/maps_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GapoktanMasterPage extends StatefulWidget {
  @override
  _GapoktanMasterPage createState() => _GapoktanMasterPage();
}

class _GapoktanMasterPage extends State<GapoktanMasterPage> {

  bool _isLoading = true;
//  bool _checkedValue = false;
  List<String> ressChecked = [];

  var tmpArray = [];

  var userStatus = List<bool>();
  SharedPreferences sharedPrefs;

//  List GapoktanData = List<ListGapoktanData>();
  String _currText = '';
  int sCount = 0;

  final blocListMasterGapoktan = ListMasterGapoktanBloc();

  List _gapoktanData = List<ListMasterGapoktan>();


  List<ListMasterGapoktan> dataGapoktan = [];

  initView() async {

    var params = {
      "gapoktan": ""
    };

    await blocListMasterGapoktan.getListMasterGapoktanBloc(params, (status,error,message,model) async {
      GetListMasterGapoktanData dataM = model;
      sharedPrefs = await SharedPreferences.getInstance();
//      sharedPrefs.clear();
      for(int i=0; i < dataM.data.length; i++) {
        setState(() {

          userStatus.add((sharedPrefs.getBool(dataM.data[i].id_gapoktan) ?? false));
        });
      }

      if(sharedPrefs.containsKey('listgapoktanmaster')) {
        if(sharedPrefs.getString('listgapoktanmaster').contains(',')) {

          var dataArray =sharedPrefs.getString('listgapoktanmaster').split(",");
          dataArray.forEach((element) {
            ressChecked.add(element);
          });
        } else {
          ressChecked.add(sharedPrefs.getString('listgapoktanmaster'));
        }


      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<List<ListMasterGapoktan>> getGapoktanData() async{
    var params = {
      "gapoktan": ""
    };


    await blocListMasterGapoktan.getListMasterGapoktanBloc(params, (status, error, message, model){

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
              future: getGapoktanData(),//getGapoktanData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (snapshot.data == null) {
                  return Container(child: Center(child: Text("Loading...")));
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(snapshot.data[index].nama_gapoktan),
                          trailing: Checkbox(
                              value:  userStatus[index],
                              onChanged: (bool val) {
                                setState(() {
                                  userStatus[index] = !userStatus[index];

                                  if(val) {
                                    _currText = snapshot.data[index].id;
                                    _AddToList(_currText,val);
                                    print(_currText);
                                  } else {
                                    _currText = snapshot.data[index].id;
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
                  bool CheckValue = sharedPrefs.containsKey('listgapoktanmaster');

                  if(CheckValue) {
                    ParamsCheck = sharedPrefs.getString('listgapoktanmaster');
                  }
                } else {
                  bool CheckValue = sharedPrefs.containsKey('listgapoktanmaster');

                  if(CheckValue) {
                    ParamsCheck = sharedPrefs.getString('listgapoktanmaster');
                  } else {
                    ParamsCheck = "";
                  }
                }

                print("ini datanya : $ParamsCheck");

                //Navigator.pushReplacementNamed(context, '/list_gapoktan', arguments: ParamsCheck);
//                  Navigator.of(context).pushReplacementNamed('/list_gapoktan', arguments: ParamsCheck);

//                  Navigator.of(context).pushReplacementNamed('/prelogin_menu');

                Navigator.of(context).pushReplacement(new MaterialPageRoute(settings: const RouteSettings(name: '/maps_page_gapoktan'), builder: (context) => new MapsGapoktanPage(dataLayer: ParamsCheck, )));
//                  routeToWidgetAndReplace(context, MapsPage(dataLayer: ParamsCheck,)).then((value) {
//                    setPotrait();
//                  });
//                routeToWidget(context, FormPengajuanPage());
              },
            )
        ),
      ),

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initView();
//    restore();

  }

  _AddToList(String checkedValue, bool val) async {
    sharedPrefs = await SharedPreferences.getInstance();
    bool CheckValue = sharedPrefs.containsKey('listgapoktanmaster');
    if(val) {
//      bool CheckValue = sharedPrefs.containsKey('listgapoktan');

      ressChecked.add(checkedValue);
      sharedPrefs.setBool(checkedValue, val);
      String ParamsCheck = ressChecked.join(',');
      sharedPrefs.setString("listgapoktanmaster", ParamsCheck);
//      sharedPrefs.setString(checkedValue, checkedValue);

    } else {
//      ressChecked.remove(checkedValue);

      if(CheckValue) {
        if(sharedPrefs.getString("listgapoktanmaster").contains(",")) {
          List<String> dataArray = sharedPrefs.getString("listgapoktanmaster").split(",");
          dataArray.removeWhere((element) => element == checkedValue);
          ressChecked.removeWhere((element) => element == checkedValue);
          String ParamsCheck = ressChecked.join(',');
          sharedPrefs.setString("listgapoktanmaster", ParamsCheck);
        } else {
          sharedPrefs.remove(checkedValue);
          ressChecked.removeWhere((element) => element == checkedValue);
          String ParamsCheck = ressChecked.join(',');
          sharedPrefs.setString("listgapoktanmaster", ParamsCheck);
        }
      } else {

        sharedPrefs.remove(checkedValue);
        ressChecked.removeWhere((element) => element == checkedValue);
        String ParamsCheck = ressChecked.join(',');
        sharedPrefs.setString("listgapoktanmaster", ParamsCheck);
      }
    }


  }


}