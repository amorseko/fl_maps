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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Padding(
                padding: new EdgeInsets.fromLTRB(10, 10, 10, 0),
              ),
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
                          komoditiData: _KomoditiData[index]
                      );
                    },

                  ),
                ),
              ),
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
    );
  }
}

class KomoditiList extends StatelessWidget {
  final int index;
  final ListKomoditiData komoditiData;


  const KomoditiList({Key key, this.index, this.komoditiData});


  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: index != -1
              ? ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Card( //                           <-- Card widget
              child: ListTile(
                title: Text(komoditiData.name),
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
}