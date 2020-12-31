import 'dart:async';
import 'package:fl_maps/src/ui/main/gapoktan/list_gapoktan_select.dart';
import 'package:fl_maps/src/ui/main/main_page.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fl_maps/src/bloc/bloc_maps_gapoktan.dart';
import 'package:fl_maps/src/model/model_maps.dart';
import 'package:fl_maps/src/bloc/bloc_total_data.dart' as blocTotal;
import 'package:fl_maps/src/model/model_total_data.dart';


class MapsGapoktanPage extends StatefulWidget {
  String dataLayer;
  _MapsGapoktanPage createState() => _MapsGapoktanPage();
  MapsGapoktanPage({this.dataLayer});
}

class _MapsGapoktanPage extends State<MapsGapoktanPage> {

  bool _isLoading = true;
  String TotalGapoktan, TotalBantuan, TotalKinerja;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  final sliderPosition = new ValueNotifier(0.0);

  static final CameraPosition initiallocation = CameraPosition(
      target: LatLng(-6.2104268598769155, 106.92790992558002),
      tilt: 0.0,
      zoom: 3.8,
      bearing: 0.0
  );

  GoogleMapController _controller;

  void initState() {
    super.initState();
    _isLoading = false;
    new Timer(const Duration(milliseconds: 150), () {
      initView();
    });
  }

  initView() async {
    String datanya;
    datanya = widget.dataLayer;

    var params = {
      "gapoktan" : widget.dataLayer,
    };

    await blocTotal.bloc.getListTotalData(params,(status,error,message,model) {
      GetListModelTotalData dataM = model;
      setState(() {
        TotalBantuan = dataM.data[0].total_bantuan;
        TotalGapoktan = dataM.data[0].total_gapoktan;
        TotalKinerja = dataM.data[0].total_kinerja;

      });

    });

    await bloc.getListMapsGapoktanBloc(params, (status,error,message, model) {
      GetMapsPartModels dataM = model;
      print(dataM.data.length);
      for(int i=0; i < dataM.data.length; i++) {
        print(dataM.data[i].gapoktan);
        _add(i.toString(), double.parse(dataM.data[i].lat), double.parse(dataM.data[i].long), dataM.data[i].gapoktan, dataM.data[i].nama_kegiatan, dataM.data[i].nomor_spk, dataM.data[i].nama_produk, dataM.data[i].alamat, dataM.data[i].nama_pic, dataM.data[i].no_pic, dataM.data[i].no_telp, dataM.data[i].nama_kota, dataM.data[i].nama_provinsi);

//        MapsData.add(dataM.data.elementAt(i));
      }
    });


  }

  void _add(sCount, Lat, Long, gapoktan, nama_kegiatan, nomor_spk, nama_produk, alamat, nama_pic, no_pic, no_telp, nama_kota, nama_provinsi) {
    var markerIdVal = sCount;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(Lat,Long),
      onTap: () {
        _showModal(nama_kegiatan, gapoktan, nomor_spk, nama_produk, alamat, nama_pic, no_pic, no_telp, nama_kota, nama_provinsi);
      },
//      infoWindow: InfoWindow(title: "Nama Komoditi : $komoditi", snippet: "Nama Gapoktan : $gapoktan\nJumlah :\nKapasitas : \nKondisi : "),

    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void _closeModal(void value) {

  }


  void _showModal(nama_kegiatan, nama_gapoktan, nomor_spk, nama_produk, alamat, nama_pic, no_pic, no_telp, nama_kota, nama_provinsi) {
    Future<void> future = showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: TextWidget(
                  txtSize: 20,
                  txt: "Detail Data",

                ),
              ),
              ListTile(
//                leading: Icon(Icons.star),
                title: Text("Nama Kegiatan : $nama_kegiatan"),
              ),
              ListTile(
//                leading: Icon(Icons.star),
                title: Text("Nama Kelompok Tani : $nama_gapoktan"),
              ),
              ListTile(
//                leading: Icon(Icons.star),
                title: Text("Nomor SPK : $nomor_spk"),
              ),
              ListTile(
//                leading: Icon(Icons.star),
                title: Text("Nama Produk : $nama_produk"),
              ),
              ListTile(
//                leading: Icon(Icons.star),
                title: Text("Nama PIC : $nama_pic"),
              ),
              ListTile(
                leading: Icon(Icons.close),
                onTap: () {
                  Navigator.of(context).pop();
                },
                title: Text("Tutup"),
              ),
            ],
          ),
        );
      },
    );
    future.then((void value) => _closeModal(value));
  }


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
//            iconTheme: IconThemeData(color: Colors.white),
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    MainPage()), (Route<dynamic> route) => false),
              ),
              title: Text("Maps Gapoktan", style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.assignment,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // do something
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(settings: const RouteSettings(name: '/list_master_gapoktan'), builder: (context) => new GapoktanMasterPage()));
//                  routeToWidget(context,
//                      GapoktanPage())
//                      .then((value) {
//                    setPotrait();
//                  });
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
                    zoomControlsEnabled: true,
                    initialCameraPosition: initiallocation,
//                  markers: Set.of((_markers != null ? _markers : [])),
                    markers: Set<Marker>.of(markers.values),
                    onCameraMove:(CameraPosition cameraPosition){
//                        print("camera position: $cameraPosition.zoom");
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                    }),
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 20, right: 10),
                  child : Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        child: Card(
                          elevation: 5,
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.elliptical(150, 30)),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Column(

                          children: <Widget>[

                            Container(
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          Text('Gapoktan'),
                                          TextWidget(
                                            txt : TotalGapoktan,
                                            color: primaryColor,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                      ),
                                      Column(
                                        children: [
                                          Text('Bantuan'),
                                          TextWidget(
                                            txt : TotalBantuan,
                                            color: primaryColor,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                      ),
                                      Column(
                                        children: [
                                          Text('Kinerja'),
                                          TextWidget(
                                            txt : TotalKinerja,
                                            color: primaryColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.only(bottom: 30),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}