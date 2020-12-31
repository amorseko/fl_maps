import 'package:flutter/material.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:flutter/services.dart';
import 'package:fl_maps/src/ui/main/main_page.dart';
import 'package:fl_maps/src/bloc/bloc_insert_komoditi.dart';
import 'package:fl_maps/src/bloc/request/do_req_komoditi.dart';

class KomoditiPage extends StatefulWidget {
  @override
  _KomoditiPage createState() => _KomoditiPage();
}

class _KomoditiPage extends State<KomoditiPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isAsync = true;
  final _NamaGapoktan = TextEditingController();

  @override
  void initState() {
    _isAsync = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        title: TextWidget(txt: "Komoditi", color: colorTitle()),
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
                    controller: _NamaGapoktan,
                    decoration: InputDecoration(
                      labelText: "Nama Product",
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
                          txt: "Simpan",
                          txtSize: 14.0,
                        ),
                        elevation: 4.0,
                        color: primaryColor,
                        splashColor: hintColor,
                        onPressed: () {
                          _simpanData();
                        },
                      ),
                      height: 50.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _simpanData() {
    if(_NamaGapoktan.text != "") {
      setState(() {
        _isAsync = true;
      });
      doReqKomoditi request = doReqKomoditi(
          name: _NamaGapoktan.text,
          mode_query: "insert"
      );



      bloc.actInsertKomoditiBloc(request.toMap(),  (status, message) => {
        setState(() {
          showErrorMessage(context, message, status);
          _isAsync = false;
        })


      });
    } else {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Mohon isi text yang kosong !")));
    }
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
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, "/list_komoditi", (_) => false);
//                                      Navigator.of(context).pushReplacement(new MaterialPageRoute(settings: const RouteSettings(name: '/main_page'), builder: (context) => new MainPage()));
//                                      routeToWidget(context,MainPage()).then((value) {
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
}