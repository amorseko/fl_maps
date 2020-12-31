import 'package:fl_maps/src/bloc/request/do_req_delete_gapoktan.dart';
import 'package:fl_maps/src/bloc/request/params_maps.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:flutter/services.dart';
import 'package:fl_maps/src/ui/main/gapoktan/gapoktan.dart';
import 'package:fl_maps/src/model/model_gapoktan.dart';
import 'package:fl_maps/src/bloc/bloc_gapoktan.dart';
import 'package:fl_maps/src/bloc/bloc_delete_gapoktan.dart';
import 'package:fl_maps/src/ui/main/gapoktan/edit_gapoktan.dart';

class ListGapoktanPage extends StatefulWidget {
  @override
  _ListGapoktanPage createState() => _ListGapoktanPage();
}

class _ListGapoktanPage extends State<ListGapoktanPage> {
  bool _isAsync = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  final blocGapoktan = ListGapoktanBloc();


//  GetModelGapoktan gapoktanModel = GetModelGapoktan();



  List _GapoktanData = List<ListGapoktanData>();

  initData() async{

    reqMapsList params = reqMapsList(
        gapoktan: ""
    );

    await blocGapoktan.getListGapoktanBloc(params.toMap(), (status, error, message, model){

      GetModelGapoktan dataM = model;

      print(dataM.data.length);
      for(int i=0; i<dataM.data.length; i++){
        _GapoktanData.add(dataM.data.elementAt(i));
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
    blocGapoktan.dispose();
  }

  void removeItem(index) {
    setState(() {
      _GapoktanData.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, "/main_page", (_) => false);
          return false;
          },
        child : Scaffold(
            appBar: AppBar(
                brightness: Brightness.light,
                iconTheme: IconThemeData(color: Colors.white),
                title:
                Text("List Data Kelompok Tani",
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
                            itemCount: _GapoktanData.length,
                            itemBuilder: (context, index){
                              return GapoktanList(
                                index: index,
                                gapoktanData: _GapoktanData[index],
                                onDelete: () => removeItem(index),
                              );
                            },
                          )
                      )
                  )
                ],
              ),
            ),
            floatingActionButton: Container(
              padding: EdgeInsets.only(bottom: 50.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    child: Icon(
                        Icons.add,
                        color: Colors.white
                    ),
                    backgroundColor: primaryColor,
                    onPressed: (){
                      routeToWidget(context, GapoktanPage()).then((value) {
                        setPotrait();
                      });
//                routeToWidget(context, FormPengajuanPage());
                    },
                  )
              ),
            )
        )
    );
  }



}

class GapoktanList extends StatelessWidget {
  final int index;
  final ListGapoktanData gapoktanData;
  final VoidCallback onDelete;


  const GapoktanList({Key key, this.index, this.gapoktanData, this.onDelete}): super(key: key);


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
                height: MediaQuery.of(context).size.width/2.5,
                width: MediaQuery.of(context).size.width,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          gapoktanData.gapoktan,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
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
                                            "Provinsi : " + gapoktanData.nama_provinsi,
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
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Komoditi : " + gapoktanData.nama_komoditi,
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
                                            "Produk : " + gapoktanData.nama_produk,
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
                        IconButton(
                          icon: new Icon(Icons.edit, color: primaryColor,),
                          onPressed:(){
//                            print(index);
                            routeToWidget(context, EditGapoktanPage(idGapoktan: gapoktanData.id_gapoktan,)).then((value) {
                              setPotrait();
                            });

                          },
                        ),
                        IconButton(
                          icon: new Icon(Icons.delete, color: primaryColor,),
                          onPressed:(){
                            print(index);
                            showMessage(context, onDelete,gapoktanData.id_gapoktan);
                            //showMessage(context, onDelete,barangListDetailData.id_dpb);
//                            this.onDelete();
                          },
                        ),
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

  void showMessage(BuildContext context, onDelete, id_gapoktan){
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
                                          if(id_gapoktan != "") {
                                            reqDelGapoktan request = reqDelGapoktan(
                                              id_gapoktan: id_gapoktan,
                                            );
                                            bloc.actDelGapoktanBloc(request.toMap(),
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