import 'dart:async';

import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fl_maps/src/model/model_maps.dart';
import 'package:fl_maps/src/bloc/bloc_maps.dart';
import 'package:fl_maps/src/bloc/request/params_maps.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:fl_maps/src/ui/main/maps/list_gapoktan.dart';
import 'package:fl_maps/src/ui/main/main_page.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';

class MapsPage extends StatefulWidget {
  String dataLayer;
  @override
  _MapsPage createState() => _MapsPage();
  MapsPage({this.dataLayer});
}

class _MapsPage extends State<MapsPage> {
  bool _isLoading = true;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  final sliderPosition = new ValueNotifier(0.0);

  static final CameraPosition initiallocation = CameraPosition(
    target: LatLng(-6.210427, 106.927910),
    zoom: 20.00,
  );

  GoogleMapController _controller;

  void initState() {
    super.initState();
    _isLoading = false;
     new Timer(const Duration(milliseconds: 150), () {
      initView();
     });
  }




  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            brightness: Brightness.light,
//            iconTheme: IconThemeData(color: Colors.white),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  MainPage()), (Route<dynamic> route) => false),
            ),
            title: Text("Bantuan", style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.assignment,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                  routeToWidget(context,
                      GapoktanPage())
                      .then((value) {
                    setPotrait();
                  });
                },
              )
            ],
            centerTitle: true,
            backgroundColor: primaryColor),
        body: ProgressDialog(
          inAsyncCall: _isLoading,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  initialCameraPosition: initiallocation,
//                  markers: Set.of((_markers != null ? _markers : [])),
                  markers: Set<Marker>.of(markers.values),
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  }),
            ],
          ),
        )
    );
  }







  void _add(sCount, Lat, Long, gapoktan) {
    var markerIdVal = sCount;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(Lat,Long),
      infoWindow: InfoWindow(title: markerIdVal, snippet: gapoktan),

    );

    setState(() {
      markers[markerId] = marker;
    });
  }

//  initData() async {
//
//    reqMapsList params = reqMapsList(
//        id_user: ""
//    );
//
//    await blocGapoktan.getListGapoktanBloc(params.toMap(), (status,error,message,model) {
//      GetModelGapoktan dataM = model;
//
//      for(int i=0; i < dataM.data.length; i++) {
//        GapoktanData.add(dataM.data.elementAt(i));
//      }
//    });
//  }

  initView() async {
    String datanya;
    datanya = widget.dataLayer;
    print("ini datanya 2 : $datanya");
    reqMapsList params = reqMapsList(
        gapoktan: widget.dataLayer
    );


    await bloc.getListMapsBloc(params.toMap(), (status,error,message,model) {
      GetMapsPartModels dataM = model;
      print(dataM.data.length);
      for(int i=0; i < dataM.data.length; i++) {
//        if(SharedPreferencesHelper.getValueChecked(dataM.data[i].gapoktan.toString()) == null) {
//
//        }
        _add(i.toString(), double.parse(dataM.data[i].lat), double.parse(dataM.data[i].long), dataM.data[i].gapoktan);

//        MapsData.add(dataM.data.elementAt(i));
      }
    });




  }


}






