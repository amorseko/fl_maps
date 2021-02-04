import 'dart:convert';
import 'package:fl_maps/src/model/member_model.dart';
import 'package:fl_maps/src/utility/Sharedpreferences.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:flutter/services.dart';
import 'package:fl_maps/src/model/model_list_notif.dart';
import 'package:fl_maps/src/bloc/bloc_list_notif.dart';

class ListNotifPage extends StatefulWidget {
  @override
  _ListNotifPage createState() => _ListNotifPage();
}

class _ListNotifPage extends State<ListNotifPage> {
  bool _isAsync = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final blocListNotif = GetListNotifBloc();

  List _notifData = List<GetListdataNotif>();

  String idUser;

  initData() async {
    var data;

    SharedPreferencesHelper.getDoLogin().then((member) async {
      final memberModels = MemberModels.fromJson(json.decode(member));
      setState(() {
        idUser = memberModels.data.id;
      });

      data = {
        "id_user": idUser,
      };

      await blocListNotif.GetListNotif(data, (status, error, message, model) {
        GetListNotifModels dataM = model;

//        print(dataM.data.length);
        for (int i = 0; i < dataM.data.length; i++) {
          _notifData.add(dataM.data.elementAt(i));
        }
      });



      setState(() {
        _isAsync = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  void dispose() {
    super.dispose();
    blocListNotif.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, "/main_page", (_) => false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text("List Data Notification",
                style: TextStyle(color: Colors.white)),
            centerTitle: true,
            backgroundColor: primaryColor),
        body: ProgressDialog(
          inAsyncCall: _isAsync,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: _notifData.length,
                        itemBuilder: (context, index) {
                          return NotifList(
                            index: index,
                            notifData: _notifData[index],
                          );
                        },
                      )))
            ],
          ),
        ),
      ),
    );
  }
}

class NotifList extends StatelessWidget {
  final int index;
  final GetListdataNotif notifData;

  const NotifList({Key key, this.index, this.notifData}) : super(key: key);

  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: index != -1
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
//                        height: MediaQuery.of(context).size.width / 2.5,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  child: Text(
                                    "Title : " + notifData.title,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  child: Text(
                                    "Message : " + notifData.message,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width / 1.3,
                                  child: Text(
                                    "Type : " + notifData.type,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  child: Text(
                                    "Tanggal & Waktu : " + notifData.date_time,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 9,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 50,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey))));
  }
}
