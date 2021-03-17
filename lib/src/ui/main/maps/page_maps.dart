import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

//import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:fl_maps/src/model/member_model.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/utility/Sharedpreferences.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fl_maps/src/model/model_maps.dart';
import 'package:fl_maps/src/bloc/bloc_maps.dart';
import 'package:fl_maps/src/ui/main/maps/list_gapoktan.dart';
import 'package:fl_maps/src/ui/main/main_page.dart';
import 'package:fl_maps/src/bloc/bloc_total_data.dart' as blocTotal;
import 'package:fl_maps/src/model/model_total_data.dart';
import 'package:http/http.dart' as http;
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:fl_maps/src/bloc/bloc_list_maps_gapoktan_new.dart' as blocMapsGapoktan;
import 'package:fl_maps/src/model/model_maps_gapoktan_new.dart';
import 'package:fl_maps/src/bloc/bloc_list_maps_komoditi.dart' as blocMapsKomoditi;
import 'package:fl_maps/src/model/model_maps_komoditi.dart';


class MapsPage extends StatefulWidget {
  String dataLayer;
  @override
  _MapsPage createState() => _MapsPage();
  MapsPage({this.dataLayer});
}

class _MapsPage extends State<MapsPage> with SingleTickerProviderStateMixin {

//  static const IconData filter_alt = IconData(0xe73d, fontFamily: 'MaterialIcons');

  Animation<double> _animation;
  AnimationController _animationController;

  var params;
  bool _isLoading = true;
  String TotalGapoktan, TotalBantuan, TotalKinerja;

  String Username, idUser, id_provinsi, id_gapoktan, id_kota;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  final sliderPosition = new ValueNotifier(0.0);

  static final CameraPosition initiallocation = CameraPosition(
      target: LatLng(-5.0506560942471275, 115.25509395991492),
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

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

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
                  icon: new Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      MainPage()), (Route<dynamic> route) => false),
                ),
                title: Text("Bantuan", style: TextStyle(color: Colors.white)),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // do something
                      Navigator.of(context).pushReplacement(new MaterialPageRoute(settings: const RouteSettings(name: '/gapoktan_page'), builder: (context) => new GapoktanPage()));
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
                                                  Text('Kelompok Tani', style: TextStyle(color: Colors.red),),
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
                                                  Text('Bantuan', style: TextStyle(color: Colors.red),),
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
                                                  Text('Kinerja', style: TextStyle(color: Colors.red),),
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
            ),
//            floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
            floatingActionButtonLocation: CustomFloatingActionButtonLocation(FloatingActionButtonLocation.centerFloat, 0, -200),
            floatingActionButton: FloatingActionBubble(
              // Menu items
              items: <Bubble>[

                // Floating action menu item
                Bubble(
                  title:"Kelompok Tani",
                  iconColor :Colors.white,
                  bubbleColor : Colors.blue,
                  titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
                  onPress: () {
                    params = {
                      //"gapoktan" : widget.dataLayer,
                      "id_gapoktan" : id_gapoktan != null ? id_gapoktan : "",
                      "id_provinsi" : id_provinsi != null ? id_provinsi : "",
                      "id_kota" : id_kota != null ? id_kota : "",
                    };

                    blocMapsGapoktan.bloc.getListMapsGapoktanBloc(params, (status,error,message,model) {
                      GetMapsGapoktanModels dataM = model;
                      int TotalsData = dataM.data.length;
                      print("data total :  $TotalsData");
                      for(int i=0; i < dataM.data.length; i++) {
                        print(dataM.data[i].nama_komoditi);
                        _addGapoktan(i.toString(), double.parse(dataM.data[i].lat), double.parse(dataM.data[i].long), dataM.data[i].gapoktan, dataM.data[i].jenis_produk, dataM.data[i].nama_produk, dataM.data[i].alamat, dataM.data[i].nama_pic, dataM.data[i].no_pic, dataM.data[i].no_telp, dataM.data[i].nama_kota, dataM.data[i].nama_provinsi, dataM.data[i].icon_default, dataM.data[i].icon,  dataM.data[i].nama_komoditi);

                      }
                    });
                    _animationController.reverse();
                  },
                ),
                // Floating action menu item
                Bubble(
                  title:"Bantuan",
                  iconColor :Colors.white,
                  bubbleColor : Colors.blue,
                  titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
                  onPress: () {

                    params = {
                      //"gapoktan" : widget.dataLayer,
                      "id_gapoktan" : id_gapoktan != null ? id_gapoktan : "",
                      "id_provinsi" : id_provinsi != null ? id_provinsi : "",
                      "id_kota" : id_kota != null ? id_kota : "",
                    };

                    print(params);

                    bloc.getListMapsBloc(params, (status,error,message,model) {
                      GetMapsPartModels dataM = model;
                      int TotalData = dataM.data.length;
                      print("data total :  $TotalData");




                      for(int i=0; i < dataM.data.length; i++) {
                        print(dataM.data[i].nama_komoditi);
                        _add(i.toString(), double.parse(dataM.data[i].lat), double.parse(dataM.data[i].long), dataM.data[i].gapoktan, dataM.data[i].nama_kegiatan, dataM.data[i].nomor_spk, dataM.data[i].nama_produk, dataM.data[i].alamat, dataM.data[i].nama_pic, dataM.data[i].no_pic, dataM.data[i].no_telp, dataM.data[i].nama_kota, dataM.data[i].nama_provinsi, dataM.data[i].icon_bantuan, dataM.data[i].nama_komoditi);
                      }
                    });
                    _animationController.reverse();
                  },
                ),

              ],

              // animation controller
              animation: _animation,

              // On pressed change animation state
              onPress: () => _animationController.isCompleted
                  ? _animationController.reverse()
                  : _animationController.forward(),

              // Floating Action button Icon color
              iconColor: Colors.blue,

              // Flaoting Action button Icon
              iconData: Icons.list,
              backGroundColor: Colors.white,
            ),


//
        ),
    );
  }
  void _showModalBeforeLogin(nama_kegiatan, nama_gapoktan) {
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
                title: Text("Kelompok Tani : $nama_gapoktan"),
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
  void _showModal(nama_kegiatan, nama_gapoktan, nomor_spk, nama_produk, alamat, nama_pic, no_pic, no_telp, nama_kota, nama_provinsi, nama_komoditi) {
    Future<void> future = showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: SingleChildScrollView(
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
//                leading: Icon(Icons.star),
                  title: Text("Kota : $nama_kota"),
                ),
                ListTile(
//                leading: Icon(Icons.star),
                  title: Text("Provinsi : $nama_provinsi"),
                ),
                ListTile(
//                leading: Icon(Icons.star),
                  title: Text("Nama Komoditi : $nama_komoditi"),
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
          ),

        );
      },
    );
    future.then((void value) => _closeModal(value));
  }

  void _showModalGapoktan(jenis_produk, nama_gapoktan, nama_produk, alamat, nama_pic, no_pic, no_telp, nama_kota, nama_provinsi, nama_komoditi) {
    Future<void> future = showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child : SingleChildScrollView(
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
                  title: Text("Jenis Produk : $jenis_produk"),
                ),
                ListTile(
  //                leading: Icon(Icons.star),
                  title: Text("Nama Kelompok Tani : $nama_gapoktan"),
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
                  title: Text("Kota : $nama_kota"),
                ),
                ListTile(
                  title: Text("Provinsi : $nama_provinsi"),
                ),
                ListTile(
                  title: Text("Nama Komoditi : $nama_komoditi"),
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
          ),
//          child: Wrap(
//            children: <Widget>[
//              ListTile(
//                title: TextWidget(
//                  txtSize: 20,
//                  txt: "Detail Data",
//
//                ),
//              ),
//              ListTile(
////                leading: Icon(Icons.star),
//                title: Text("Jenis Produk : $jenis_produk"),
//              ),
//              ListTile(
////                leading: Icon(Icons.star),
//                title: Text("Nama Kelompok Tani : $nama_gapoktan"),
//              ),
//              ListTile(
////                leading: Icon(Icons.star),
//                title: Text("Nama Produk : $nama_produk"),
//              ),
//              ListTile(
////                leading: Icon(Icons.star),
//                title: Text("Nama PIC : $nama_pic"),
//              ),
//              ListTile(
//                leading: Icon(Icons.close),
//                onTap: () {
//                  Navigator.of(context).pop();
//                },
//                title: Text("Tutup"),
//              ),
//            ],
//          ),
        );
      },
    );
    future.then((void value) => _closeModal(value));
  }

  void _showModalGapoktanBeforeLogin(jenis_produk, nama_gapoktan) {
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
                title: Text("Jenis Produk : $jenis_produk"),
              ),
              ListTile(
//                leading: Icon(Icons.star),
                title: Text("Kelompok Tani : $nama_gapoktan"),
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

  void _showModalKomoditi(gapoktan, nama_kegiatan, nama_produk, alamat, nama_pic, tahun, jumlah, kapasitas, tahun_pembuatan) {
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
                title: Text("Nama Kelompok Tani : $gapoktan"),
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
//                leading: Icon(Icons.star),
                title: Text("Tahun : $tahun"),
              ),
              ListTile(
//                leading: Icon(Icons.star),
                title: Text("Jumlah : $jumlah"),
              ),
              ListTile(
//                leading: Icon(Icons.star),
                title: Text("Kapasitas : $kapasitas"),
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

  void _showModalKomoditiBeforeLogin(jenis_produk, nama_gapoktan) {
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
                title: Text("Jenis Produk : $jenis_produk"),
              ),
              ListTile(
//                leading: Icon(Icons.star),
                title: Text("Kelompok Tani : $nama_gapoktan"),
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

  void _closeModal(void value) {

  }

  void _addGapoktan(sCount, Lat, Long, gapoktan, jenis_produk, nama_produk, alamat, nama_pic, no_pic, no_telp, nama_kota, nama_provinsi, icon_default, icon, nama_komoditi) async {
    var markerIdVal = sCount;

    markers.clear();

    var dataBytes;
    var request = await http.get(icon_default);
    var bytes = await request.bodyBytes;

    setState(() {
      dataBytes = bytes;
    });

    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.fromBytes(dataBytes.buffer.asUint8List()),
      position: LatLng(Lat,Long),
      onTap: () {
        if(idUser == null)
        {
          _showModalGapoktanBeforeLogin(jenis_produk, gapoktan);
        }
        else
        {
          _showModalGapoktan(jenis_produk, gapoktan, nama_produk, alamat, nama_pic, no_pic, no_telp, nama_kota, nama_provinsi, nama_komoditi);
        }
      },

    );

    setState(() {
      markers[markerId] = marker;
    });
  }



  void _addKomoditi(sCount, Lat, Long, gapoktan, nama_kegiatan, nama_produk, alamat, nama_pic, tahun, jumlah, kapasitas, tahun_pembuatan, icon_bantuan,nama_komoditi) async {
    var markerIdVal = sCount;

    markers.clear();

    var dataBytes;
    var request = await http.get(icon_bantuan);
    var bytes = await request.bodyBytes;


    final int targetWidth = 60;
    final File markerImageFile = await DefaultCacheManager().getSingleFile(icon_bantuan);

    final Uint8List markerImageBytes = await markerImageFile.readAsBytes();

    setState(() {
      dataBytes = bytes;
    });

    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.fromBytes(dataBytes.buffer.asUint8List()),
      position: LatLng(Lat,Long),
      onTap: () {
        if(idUser == null)
        {
          _showModalKomoditiBeforeLogin(nama_kegiatan, gapoktan);
        }
        else
        {

          _showModalKomoditi(gapoktan, nama_kegiatan, nama_produk, alamat, nama_pic, tahun, jumlah, kapasitas, tahun_pembuatan);
        }
      },

    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void _add(sCount, Lat, Long, gapoktan, nama_kegiatan, nomor_spk, nama_produk, alamat, nama_pic, no_pic, no_telp, nama_kota, nama_provinsi, icon_bantuan, nama_komoditi) async {
    var markerIdVal = sCount;



    markers.clear();

    var dataBytes;
    var request = await http.get(icon_bantuan);
    var bytes = await request.bodyBytes;

    setState(() {
      dataBytes = bytes;
    });

    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.fromBytes(dataBytes.buffer.asUint8List()),
      position: LatLng(Lat,Long),
      onTap: () {
        if(idUser == null)
        {
          _showModalBeforeLogin(nama_kegiatan, gapoktan);
        }
        else
        {
          _showModal(nama_kegiatan, gapoktan, nomor_spk, nama_produk, alamat, nama_pic, no_pic, no_telp, nama_kota, nama_provinsi, nama_komoditi);
          //_showModal(komoditi, gapoktan, jumlah, kapasitas, kondisi);
        }
      //  _showModal(komoditi, gapoktan, jumlah, kapasitas, kondisi);
      },
//      infoWindow: InfoWindow(title: "Nama Komoditi : $komoditi", snippet: "Nama Gapoktan : $gapoktan\nJumlah :\nKapasitas : \nKondisi : "),

    );

    setState(() {
      markers[markerId] = marker;
    });
  }


  initView() async {
    String datanya;
    datanya = widget.dataLayer;
    print("ini datanya : $datanya");
    //final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    SharedPreferencesHelper.getDoLogin().then((member) async {
      print("data member : $member");
      final memberModels = MemberModels.fromJson(json.decode(member));
      setState(() {
        Username = memberModels.data.username;
        id_kota = memberModels.data.id_kota;
        id_gapoktan = memberModels.data.id_gapoktan;
        id_provinsi = memberModels.data.id_provinsi;
        idUser = memberModels.data.id;
        params = {
          "id_komoditi" : widget.dataLayer,
          "id_gapoktan" : id_gapoktan != null ? id_gapoktan : "",
          "id_provinsi" : id_provinsi != null ? id_provinsi : "",
          "id_kota" : id_kota != null ? id_kota : "",
        };
      });
    });


    print(params);

    await blocTotal.bloc.getListTotalData(params,(status,error,message,model) {
      GetListModelTotalData dataM = model;
      setState(() {
        TotalBantuan = dataM.data[0].total_bantuan;
        TotalGapoktan = dataM.data[0].total_gapoktan;
        TotalKinerja = dataM.data[0].total_kinerja;
      });
    });

    print("data layer : " + widget.dataLayer);
    if(widget.dataLayer != "") {
      await blocMapsKomoditi.bloc.getListMapsKomoditiBloc(params, (status,error,message,model) {
        GetMapsKomoditiModels dataM = model;
        int TotalData = dataM.data.length;
        print("data total bantuan :  $TotalData");
        for(int i=0; i < dataM.data.length; i++) {
          _addKomoditi(i.toString(), double.parse(dataM.data[i].lat), double.parse(dataM.data[i].long),dataM.data[i].nama_gapoktan,dataM.data[i].nama_kegiatan,dataM.data[i].nama_produk,dataM.data[i].alamat,dataM.data[i].nama_pic,dataM.data[i].tahun,dataM.data[i].jumlah,dataM.data[i].kapasitas,dataM.data[i].tahun_pembuatan,dataM.data[i].icon,dataM.data[i].nama_komoditi);
       }

      });
    }
  }


}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  FloatingActionButtonLocation location;
  double offsetX; // Offset in X direction
  double offsetY; // Offset in Y direction
  CustomFloatingActionButtonLocation(this.location, this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }
}






