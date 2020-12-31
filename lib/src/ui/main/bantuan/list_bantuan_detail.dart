import 'package:fl_maps/src/bloc/request/do_req_delete_gapoktan.dart';
import 'package:fl_maps/src/bloc/request/do_req_delete_komoditi.dart';
import 'package:fl_maps/src/bloc/request/params_maps.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:flutter/services.dart';
import 'package:fl_maps/src/model/model_bantuan_detail.dart';
import 'package:fl_maps/src/bloc/bloc_list_bantuan_detail.dart';
import 'package:fl_maps/src/bloc/bloc_delete_bantuan.dart';

class ListBantuanDetailPage extends StatefulWidget {
  String id;
  @override
  _ListBantuanDetailPage createState() => _ListBantuanDetailPage();
  ListBantuanDetailPage({this.id});
}

class _ListBantuanDetailPage extends State<ListBantuanDetailPage> {
  bool _isAsync = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  final blocListBantuan = ListBantuanDetailBloc();

  List _bantuanData = List<GetListdataBantuanDetail>();

  initData() async{

    var params = {
      "id": widget.id,
    };

    await blocListBantuan.getListBantuanDetailBlocs(params, (status, error, message, model){

      GetModelBantuanDetail dataM = model;

      print(dataM.data.length);
      for(int i=0; i<dataM.data.length; i++){
        _bantuanData.add(dataM.data.elementAt(i));
      }

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
              context, "/list_bantuan_new", (_) => false);
          return false;
        },
        child : Scaffold(
          appBar: AppBar(
              brightness: Brightness.light,
              iconTheme: IconThemeData(color: Colors.white),
              title:
              Text("List Data Bantuan Detail",
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
  final GetListdataBantuanDetail bantuanData;
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
                height: MediaQuery.of(context).size.width/2,
                width: MediaQuery.of(context).size.width,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/1.3,
                          child : Text(
                            "Nama Bantuan : " + bantuanData.name,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),


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
                                          child: Text(
                                            "Kapasitas terpasang : " + bantuanData.kapasitas_terpasang,
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
                                          child: Text(
                                            "Jumlah : " + bantuanData.jumlah,
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
                                          child: Text(
                                            "Spesifikasi: " + bantuanData.spesifikasi,
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
                                          child: Text(
                                            "Tahun pembuatan: " + bantuanData.tahun_pembuatan,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
//                          IconButton(
//                            icon: new Icon(Icons.edit, color: primaryColor,),
//                            onPressed:(){
////                            print(index);
//                              routeToWidget(context, EditBantuanPage(id_bantuan: bantuanData.id_bantuan,)).then((value) {
//                                setPotrait();
//                              });
//
//                            },
//                          ),
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