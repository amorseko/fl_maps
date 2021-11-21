import 'dart:convert';

import 'package:fl_maps/src/bloc/request/do_req_delete_komoditi.dart';
import 'package:fl_maps/src/model/member_model.dart';
import 'package:fl_maps/src/ui/main/bantuan/list_bantuan_detail.dart';
import 'package:fl_maps/src/utility/Sharedpreferences.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:flutter/services.dart';
import 'package:fl_maps/src/model/model_bantuan_new.dart';
import 'package:fl_maps/src/bloc/bloc_list_bantuan_new.dart';
import 'package:fl_maps/src/bloc/bloc_delete_bantuan.dart';

class ListBantuanNewPage extends StatefulWidget {
  @override
  _ListBantuanNewPage createState() => _ListBantuanNewPage();
}

class _ListBantuanNewPage extends State<ListBantuanNewPage> {
  bool _isAsync = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  final blocListBantuan = ListBantuanNewBloc();

  List _bantuanData = List<GetListdataBantuanNew>();
  String Username, id_kota, id_gapoktan, id_provinsi, idUser;
  initData() async{
    var data;
//    reqMapsList params = reqMapsList(
//        gapoktan: ""
//    );

    SharedPreferencesHelper.getDoLogin().then((member) async {
      print("data member : $member");
      final memberModels = MemberModels.fromJson(json.decode(member));
      setState(() {
        Username = memberModels.data.username;
        id_kota = memberModels.data.id_kota;
        id_gapoktan = memberModels.data.id_gapoktan;
        id_provinsi = memberModels.data.id_provinsi;
        idUser = memberModels.data.id;
      });

      data = {
        "id_provinsi": id_provinsi,
        "id_kota": id_kota,
        "id_gapoktan": id_gapoktan,

      };

      print("Params : $data");
      await blocListBantuan.getListBantuanBlocs(data, (status, error, message, model){

        GetModelBantuanNew dataM = model;

        print(dataM.data.length);
        for(int i=0; i<dataM.data.length; i++){
          _bantuanData.add(dataM.data.elementAt(i));
        }


      });

      setState(() {
        _isAsync=false;
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
    blocListBantuan.dispose();
  }

  void removeItem(index) {
    setState(() {
      _bantuanData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, "/maps_page", (_) => false);
          return false;
        },
        child : Scaffold(
          appBar: AppBar(
              brightness: Brightness.light,
              iconTheme: IconThemeData(color: Colors.white),
              title:
              Text("List Data Bantuan",
                  style: TextStyle(color: Colors.white)
              ),
              centerTitle: true,
              backgroundColor: primaryColor
          ),
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
                          itemCount: _bantuanData.length,
                          itemBuilder: (context, index){
                            return BantuanList(
                              index: index,
                              bantuanData: _bantuanData[index],
                              onDelete: () => removeItem(index),
                            );
                          },
                        )
                    )
                )
              ],
            ),

          ),
//            floatingActionButton: Container(
//              padding: EdgeInsets.only(bottom: 50.0),
//              child: Align(
//                  alignment: Alignment.bottomRight,
//                  child: FloatingActionButton(
//                    child: Icon(
//                        Icons.add,
//                        color: Colors.white
//                    ),
//                    backgroundColor: primaryColor,
//                    onPressed: (){
//                      routeToWidget(context, BantuanPage()).then((value) {
//                        setPotrait();
//                      });
////                routeToWidget(context, FormPengajuanPage());
//                    },
//                  )
//              ),
//            )
        )

    );
  }

}

class BantuanList extends StatelessWidget {
  final int index;
  final GetListdataBantuanNew bantuanData;
  final VoidCallback onDelete;

  const BantuanList({Key key, this.index, this.bantuanData, this.onDelete}): super(key: key);

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
//                height: MediaQuery.of(context).size.width/1.9,
                width: MediaQuery.of(context).size.width,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/1.3,
                          child:  Text(
                            "Nama Kegiatan : " + bantuanData.nama_kegiatan,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        )


                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width/1.3,
                                          child: Text(
                                            "Nama Kelompok Tani : " + bantuanData.nama_gapoktan,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width/1.3,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "No. SPK : " + bantuanData.nomor_spk,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width/1.3,
                                          child: Text(
                                            "Tahun : " + bantuanData.tahun,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width/1.3,
                                          child: Text(
                                            "Status SPK : " + bantuanData.tahap_bantuan,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                )

                              ],
                            )
                          ],
                        )
                      ],
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          IconButton(
                            icon: new Icon(Icons.remove_red_eye, color: primaryColor,),
                            onPressed:(){
                            print(bantuanData.id_bantuan);
                              routeToWidget(context, ListBantuanDetailPage(id: bantuanData.id_bantuan,)).then((value) {
                                setPotrait();
                              });

                            },
                          ),
//                          IconButton(
//                            icon: new Icon(Icons.delete, color: primaryColor,),
//                            onPressed:(){
//                              print(index);
//                              showMessage(context, onDelete,bantuanData.id_bantuan);
//                            },
//                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ): Container(
              height: 50,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey
              )
          )
      ),
    );
  }

  showAlertDialog(BuildContext context, message) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );


    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void resultSuccess(context,bool status,onDelete) {
    if(status == false) {
      this.onDelete();
    } else {
      showAlertDialog(context, "Failed delete !");
    }
  }

  void showMessage(BuildContext context, onDelete, id){
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height/ 4,
            child:new SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              // height: MediaQuery.of(context).size.width / 2,
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
                                  Text("Are you sure want to delete this item ?",
                                    style: TextStyle(
                                        fontSize: 15
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {

                                          Navigator.pop(context);
                                          if(id != "") {
                                            reqDelKomoditi request = reqDelKomoditi(
                                              id: bantuanData.id_bantuan,
                                            );
                                            bloc.actDelBantuanBloc(request.toMap(),
                                                    (status, message) => {
                                                  resultSuccess(context, status, onDelete)
                                                });
                                          }



                                        },
                                        child: Container(
                                            width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                            height: 50,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius: new BorderRadius.all(
                                                    const Radius.circular(30.0)),
                                                color: primaryColor),
                                            child: Text("OK",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white
                                              ),
                                            )
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                            width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                            height: 50,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius: new BorderRadius.all(
                                                    const Radius.circular(30.0)),
                                                color: primaryColor),
                                            child: Text("CANCEL",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white
                                              ),
                                            )
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),

          );
        });
  }
}