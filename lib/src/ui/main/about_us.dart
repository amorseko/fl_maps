import 'package:fl_maps/src/utility/Colors.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fl_maps/src/bloc/about_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/model/aboutus_model.dart';
import 'package:fl_maps/src/utility/Colors.dart';
//import 'package:fl_maps/src/widget/Strings.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';


class AboutUS extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return AboutUSState();
  }

//  AboutUS(this.blocAbout);
}


class AboutUSState extends State<AboutUS> {
  AboutsModels models;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.white),
          title:
          Text("Information", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: primaryColor),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 30, left: 30, right: 30),
          child: Column(
            children: <Widget>[_content()],
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return Container(child: Html(data: _getTerm()));
  }


  _fetchData() {
//    bloc
//        .aboutBloc((status, error, message, models) => {_renderView(models)});
    var req = {
      "id" : "",
    };
    bloc.aboutBloc(req, (status,error,message,model)
    {
//      AboutsModels dataM = model;

      _renderView(model);
    });
  }

  String _getTerm() {
    String description = "";
    if (models != null && models.data.elementAt(0) != null) {
      description= models.data[0].info;
    } else {
      description = "";
    }
//    print(models.data[0].data);
    return description;
  }

  _renderView(AboutsModels aboutModel) async {
    setState(() {
      this.models = aboutModel;
//      print("data models : " + models.data[0].info);
    });
  }

}
