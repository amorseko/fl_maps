import 'package:fl_maps/src/bloc/request/do_req_delete_komoditi.dart';
import 'package:fl_maps/src/bloc/request/params_maps.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:flutter/services.dart';
import 'package:fl_maps/src/ui/main/komoditi/komiditi.dart';
import 'package:fl_maps/src/model/model_list_komoditi.dart';
import 'package:fl_maps/src/bloc/bloc_list_komoditi.dart';
import 'package:fl_maps/src/bloc/bloc_delete_komoditi.dart';
import 'package:fl_maps/src/ui/main/komoditi/edit_komoditi.dart';

class ListKomoditiPage extends StatefulWidget {
  @override
  _ListKomoditiPage createState() => _ListKomoditiPage();
}

class _ListKomoditiPage extends State<ListKomoditiPage> {

  bool _isAsync = true;
  final blocKomoditi = ListKomoditiBloc();

  List _KomoditiData = List<ListKomoditiData>();

  @override
  void dispose() {
    super.dispose();
    blocKomoditi.dispose();
  }

  initData() async{

    reqMapsList params = reqMapsList(
        gapoktan: ""
    );

    await blocKomoditi.getListKomoditiBlocs(params.toMap(), (status, error, message, model){

      GetListKomoditiData dataM = model;

      print(dataM.data.length);
      for(int i=0; i<dataM.data.length; i++){
        _KomoditiData.add(dataM.data.elementAt(i));
      }

      setState(() {
        _isAsync=false;
      });
    });

  }

  void removeItem(index) {
    setState(() {
      _KomoditiData.removeAt(index);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, "/main_page", (_) => false);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
              brightness: Brightness.light,
              iconTheme: IconThemeData(color: Colors.white),
              title:
              Text("List Data Komoditi",
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
                          itemCount: _KomoditiData.length,
                          itemBuilder: (context, index){
                            return KomoditiList(
                              index: index,
                              komoditiData: _KomoditiData[index],
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
                    routeToWidget(context, KomoditiPage()).then((value) {
                      setPotrait();
                    });
//                routeToWidget(context, FormPengajuanPage());
                  },
                )
            ),
          )
      ),
    );
  }
}

class KomoditiList extends StatelessWidget {
  final int index;
  final ListKomoditiData komoditiData;
  final VoidCallback onDelete;


  const KomoditiList({Key key, this.index, this.komoditiData, this.onDelete}): super(key: key);


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
                  height: MediaQuery.of(context).size.width/4,
                  width: MediaQuery.of(context).size.width,
                  child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              komoditiData.name,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: new Icon(Icons.edit, color: primaryColor,),
                              onPressed:(){
//                            print(index);
                                routeToWidget(context, EditKomoditiPage(id: komoditiData.id,)).then((value) {
                                  setPotrait();
                                });

                              },
                            ),
                            IconButton(
                              icon: new Icon(Icons.delete, color: primaryColor,),
                              onPressed:(){
                                print(index);
                                showMessage(context, onDelete,komoditiData.id);
                              },
                            ),
                          ],
                        )
                      ],
                  ),
                ),
            )
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
                                              id: id,
                                            );
                                            bloc.actDelKomoditiBloc(request.toMap(),
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
}