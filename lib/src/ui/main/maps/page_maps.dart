import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_maps/src/model/default_model.dart';
import 'package:fl_maps/src/ui/main/about_us.dart';
import 'package:fl_maps/src/ui/main/bantuan/list_bantuan_new.dart';
import 'package:fl_maps/src/ui/main/kinerja/list_kinerja_only.dart';
import 'package:fl_maps/src/ui/main/list_notif.dart';
import 'package:fl_maps/src/ui/main/pesan.dart';
import 'package:fl_maps/src/ui/main/settings/settings_page.dart';
import 'package:fl_maps/src/ui/pre_login.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

//import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:fl_maps/src/model/member_model.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/utility/Sharedpreferences.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:fl_maps/src/bloc/doUpdatePictBloc.dart' as blocProfile;
import 'package:fl_maps/src/bloc/bloc_fcm.dart' as blocFCM;


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

  String Username, idUser, id_provinsi, id_gapoktan, id_kota, _image, _pict;


  File _images;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final sliderPosition = new ValueNotifier(0.0);

  static final CameraPosition initiallocation = CameraPosition(
      target: LatLng(-5.0506560942471275, 115.25509395991492),
      tilt: 0.0,
      zoom: 3.8,
      bearing: 0.0
  );

  GoogleMapController _controller;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) {
      print(token);
    }
    );
  }


  Future onSelectNotification(String payload) async {
    if(payload != "")
    {
      routeToWidget(context,ListNotifPage()).then((value) {
        setPotrait();
      });
    }
  }

  Future<void> _demoNotification(dynamic PayLoad) async {
    final dynamic data = jsonDecode(PayLoad['data']['data']);
    final dynamic notification = jsonDecode(PayLoad['data']['notification']);
    final int idNotification = data['id'] != null ? int.parse(data['id']) : 1;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Assiapbun', 'notification', 'List Notification',
        importance: Importance.max,
        playSound: true,
        showProgress: true,
        priority: Priority.high,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS : iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, notification['title'], notification['body'], platformChannelSpecifics, payload: 'test');
  }

  void showNotification(dynamic Payload) async {
    await _demoNotification(Payload);
  }

  void getMessage() {
//    final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");
    var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          await showNotification(message);
//
        },
        onBackgroundMessage: onBackgroundMessage,
        onResume: (Map<String, dynamic> message) async {
          print('on resume $message');
          await showNotification(message);
        },
        onLaunch: (Map<String, dynamic> message) async {
          print('on launch $message');
          await showNotification(message);
        }
    );
  }

  void initState() {
    super.initState();
    _isLoading = false;
     new Timer(const Duration(milliseconds: 150), () {
      initView();

      _animationController.reverse();
     });

    getMessage();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

  }

  Widget _buildProfileImage() {
    return Container(
      child: Container(
        height: 100,
        width: 100,
        child: Material(
          elevation: 4.0,
          shape: CircleBorder(),
          color: hintColor,
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(8),
            child: new InkWell(
              onTap: () {
                _showPicker(context);
              },
              child:  _image != "" ? Container(
                  decoration: new BoxDecoration(
                      border: Border.all(color: primaryColor, width: 2),
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image:NetworkImage(_pict),
                      )
                    //              ),

                  ) ) : _images != null ? Container(
                  decoration: new BoxDecoration(
                      border: Border.all(color: primaryColor, width: 2),
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image:FileImage(File(_images.toString())),
                      )
                    //              ),

                  )
              ) : Container(
                padding: EdgeInsets.all(22),
                child: Center(
                  child: Icon(
                    Icons.camera_alt, color: Colors.white, size: 40.0,
                  ),
                ),

              ),

            ),
//
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    );

    return Text(
      idUser == null ? "ASIAPP" : Username,
      style: _nameTextStyle,
    );
  }

  Widget _navDraw(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                idUser != null ? _buildProfileImage() : SizedBox(height: 100,),
                SizedBox(height: 5),
                _buildFullName(),
              ],
            ),

          ),
          idUser == null ? SizedBox(width: 0, height: 0) :  ListTile(
            title: Text("BANTUAN",
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold)),
            leading: new Image.asset(
              "assets/icons/icons_peserta.png",
              fit: BoxFit.cover, width: 40,),
            onTap: ()  {
              routeToWidget(context, new ListBantuanNewPage());
            },
          ),
          ListTile(
            title: Text("MAP",
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold)),
            leading: new Image.asset(
              "assets/icons/icon_maps_bantuan.png",
              fit: BoxFit.cover, width: 40,),
            onTap: () {

              routeToWidget(context, new MapsPage());
            },
          ),
          idUser == null ? SizedBox(width: 0, height: 0) : ListTile(
            title: Text("KINERJA BANTUAN",
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold)),
            leading: new Image.asset(
              "assets/icons/icon_kinerja.png",
              fit: BoxFit.cover, width: 40,),
            onTap: ()  {
              routeToWidget(context, new ListKinerjaOnlyPage());
            },
          ),
          idUser == null ? ListTile(
            title: Text("LOGIN",
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold)),
            leading: new Image.asset(
              "assets/icons/icons_syaratketentuan.png",
              fit: BoxFit.cover, width: 40,),
            onTap: ()  {
              routeToWidget(context, new PreLoginActivity());
            },
          ) : SizedBox(width : 0, height: 0),
          idUser == null ? SizedBox(width: 0, height: 0) : ListTile(
            title: Text("PESAN",
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold)),
            leading: new Image.asset(
              "assets/icons/icon_pesan.png",
              fit: BoxFit.cover, width: 40,),
            onTap: ()  {
              routeToWidget(context, new PesanPage());

            },
          ),

          idUser == null ? SizedBox(width: 0, height: 0) : ListTile(
            title: Text("SETTINGS",
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold)),
            leading: new Image.asset(
              "assets/icons/icon_settings.png",
              fit: BoxFit.cover, width: 40,),
            onTap: () {
              routeToWidget(context, new SettingsPage());
            },
          ),
          idUser == null ? SizedBox(width: 0, height: 0) : ListTile(
            title: Text("LOGOUT",
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold)),
            leading: new Image.asset(
              "assets/icons/icons_exit.png",
              fit: BoxFit.cover, width: 40,),
            onTap: () {
              _logout();
            },
          ),
          ListTile(
            title: Text("INFORMATION",
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold)),
            leading: new Image.asset(
              "assets/icons/icon_information.png",
              fit: BoxFit.cover, width: 40,),
            onTap: () {

              routeToWidget(context, new AboutUS());
            },
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Navigator.pushNamedAndRemoveUntil(
          //     context, "/main_page", (_) => false);
          return false;
        },
        child: Scaffold(
            drawer: _navDraw(context),
            appBar: AppBar(
                brightness: Brightness.light,
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
                                                  SizedBox(
                                                    height: MediaQuery.of(context).size.height / 40,
                                                  ),
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
                                                  SizedBox(
                                                    height: MediaQuery.of(context).size.height / 40,
                                                  ),
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
                                                  SizedBox(
                                                    height: MediaQuery.of(context).size.height / 40,
                                                  ),
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
                  ),

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
                        try {
                          _addGapoktan(i.toString(), double.parse(dataM.data[i].lat), double.parse(dataM.data[i].long), dataM.data[i].gapoktan, dataM.data[i].jenis_produk, dataM.data[i].nama_produk, dataM.data[i].alamat, dataM.data[i].nama_pic, dataM.data[i].no_pic, dataM.data[i].no_telp, dataM.data[i].nama_kota, dataM.data[i].nama_provinsi, dataM.data[i].icon_default, dataM.data[i].icon,  dataM.data[i].nama_komoditi);

                        } catch (e) {
                          print(e);
                        }

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
                        try {
                          _add(i.toString(), double.parse(dataM.data[i].lat), double.parse(dataM.data[i].long), dataM.data[i].gapoktan, dataM.data[i].nama_kegiatan, dataM.data[i].nomor_spk, dataM.data[i].nama_produk, dataM.data[i].alamat, dataM.data[i].nama_pic, dataM.data[i].no_pic, dataM.data[i].no_telp, dataM.data[i].nama_kota, dataM.data[i].nama_provinsi, dataM.data[i].icon_bantuan, dataM.data[i].nama_komoditi);

                        } catch(e) {
                          print(e);
                        }
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

  _logout() {
    SharedPreferencesHelper.clearAllPreference();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        PreLoginActivity()), (Route<dynamic> route) => false);
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

      if(member != "") {
        final memberModels = MemberModels.fromJson(json.decode(member));
        setState(() {
          Username = memberModels.data.username;
          id_kota = memberModels.data.id_kota;
          id_gapoktan = memberModels.data.id_gapoktan;
          id_provinsi = memberModels.data.id_provinsi;
          idUser = memberModels.data.id;
          _pict = memberModels.data.pict;
          _image = memberModels.data.images;
          if(idUser != null)
          {
            _firebaseMessaging.subscribeToTopic('all');
            _firebaseMessaging.getToken().then((token) {
              var data = {
                'token' : token,
                'id' : idUser
              };
              print(data);
              blocFCM.bloc.actUpdateToken(data,(status, message) => {
                print("result update :" + message)
              });

              print(token);
            });
          }



        });
      }


      if(idUser != "") {
        params = {
          "id_komoditi" : widget.dataLayer,
          "id_gapoktan" : id_gapoktan != null ? id_gapoktan : "",
          "id_provinsi" : id_provinsi != null ? id_provinsi : "",
          "id_kota" : id_kota != null ? id_kota : "",
        };

        await blocMapsGapoktan.bloc.getListMapsGapoktanBloc(params, (status,error,message,model) {
          GetMapsGapoktanModels dataM = model;
          int TotalsData = dataM.data.length;
          print("data total :  $TotalsData");
          for(int i=0; i < dataM.data.length; i++) {
            // print("data long : " + dataM.data[i].long);
            try {
              _addGapoktan(i.toString(), double.parse(dataM.data[i].lat), double.parse(dataM.data[i].long), dataM.data[i].gapoktan, dataM.data[i].jenis_produk, dataM.data[i].nama_produk, dataM.data[i].alamat, dataM.data[i].nama_pic, dataM.data[i].no_pic, dataM.data[i].no_telp, dataM.data[i].nama_kota, dataM.data[i].nama_provinsi, dataM.data[i].icon_default, dataM.data[i].icon,  dataM.data[i].nama_komoditi);

            } catch (e) {
              print(e);
            }

          }
        });

        var paramsTotalData = {
          "gapoktan" : id_gapoktan
        };

        await blocTotal.bloc.getListTotalData(paramsTotalData,(status,error,message,model) {
          GetListModelTotalData dataM = model;
          print("data total bantuan : " + dataM.data[0].total_bantuan);
          setState(() {
            TotalBantuan = dataM.data[0].total_bantuan;
            TotalGapoktan = dataM.data[0].total_gapoktan;
            TotalKinerja = dataM.data[0].total_kinerja;
          });
        });

        // print(widget.dataLayer);

        if(widget.dataLayer == "" || widget.dataLayer == null) {

        } else {
            await blocMapsKomoditi.bloc.getListMapsKomoditiBloc(params, (status,error,message,model) {
              GetMapsKomoditiModels dataM = model;
              int TotalData = dataM.data.length;
              print("data total bantuan :  $TotalData");
              for(int i=0; i < dataM.data.length; i++) {
                try {
                  _addKomoditi(i.toString(), double.parse(dataM.data[i].lat), double.parse(dataM.data[i].long),dataM.data[i].nama_gapoktan,dataM.data[i].nama_kegiatan,dataM.data[i].nama_produk,dataM.data[i].alamat,dataM.data[i].nama_pic,dataM.data[i].tahun,dataM.data[i].jumlah,dataM.data[i].kapasitas,dataM.data[i].tahun_pembuatan,dataM.data[i].icon,dataM.data[i].nama_komoditi);
                } catch (e) {
                  print(e);
                }

              }

            });
        }
      }

    });


    if(idUser == "") {
      params = {
        "id_komoditi" : widget.dataLayer,
        "id_gapoktan" : id_gapoktan != null ? id_gapoktan : "",
        "id_provinsi" : id_provinsi != null ? id_provinsi : "",
        "id_kota" : id_kota != null ? id_kota : "",
      };

      await blocMapsGapoktan.bloc.getListMapsGapoktanBloc(params, (status,error,message,model) {
        GetMapsGapoktanModels dataM = model;
        int TotalsData = dataM.data.length;
        print("data total :  $TotalsData");
        for(int i=0; i < dataM.data.length; i++) {
          // print("data double parse : " + dataM.data[i].long != 0 ? "lebih dari 0" : "data nya : " + dataM.data[i].long);
         // _addGapoktan(i.toString(), double.parse(dataM.data[i].lat), double.parse(dataM.data[i].long), dataM.data[i].gapoktan, dataM.data[i].jenis_produk, dataM.data[i].nama_produk, dataM.data[i].alamat, dataM.data[i].nama_pic, dataM.data[i].no_pic, dataM.data[i].no_telp, dataM.data[i].nama_kota, dataM.data[i].nama_provinsi, dataM.data[i].icon_default, dataM.data[i].icon,  dataM.data[i].nama_komoditi);
          try {
            _addGapoktan(i.toString(), double.parse(dataM.data[i].lat), double.parse(dataM.data[i].long), dataM.data[i].gapoktan, dataM.data[i].jenis_produk, dataM.data[i].nama_produk, dataM.data[i].alamat, dataM.data[i].nama_pic, dataM.data[i].no_pic, dataM.data[i].no_telp, dataM.data[i].nama_kota, dataM.data[i].nama_provinsi, dataM.data[i].icon_default, dataM.data[i].icon,  dataM.data[i].nama_komoditi);

          } catch (e) {
            print(e);
          }
        }
      });

      //print("Data params :" + params);


      await blocTotal.bloc.getListTotalData(params,(status,error,message,model) {
        GetListModelTotalData dataM = model;
        setState(() {
          TotalBantuan = dataM.data[0].total_bantuan;
          TotalGapoktan = dataM.data[0].total_gapoktan;
          TotalKinerja = dataM.data[0].total_kinerja;
        });
      });

      //print("data layer : " + widget.dataLayer);
      if(widget.dataLayer != "" || widget.dataLayer != null) {
        await blocMapsKomoditi.bloc.getListMapsKomoditiBloc(params, (status,error,message,model) {
          GetMapsKomoditiModels dataM = model;
          int TotalData = dataM.data.length;
          print("data total bantuan :  $TotalData");
          for(int i=0; i < dataM.data.length; i++) {
            try {
              _addKomoditi(i.toString(), double.parse(dataM.data[i].lat), double.parse(dataM.data[i].long),dataM.data[i].nama_gapoktan,dataM.data[i].nama_kegiatan,dataM.data[i].nama_produk,dataM.data[i].alamat,dataM.data[i].nama_pic,dataM.data[i].tahun,dataM.data[i].jumlah,dataM.data[i].kapasitas,dataM.data[i].tahun_pembuatan,dataM.data[i].icon,dataM.data[i].nama_komoditi);
            } catch (e) {
              print(e);
            }

          }

        });
      }
    }

  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _images = image;
      if(_images != null)
      {
        updateData(_images);
      }
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _images = image;

      if(_images != null)
      {
        updateData(_images);
      }
    });
  }

  updateData(File __image) async {
    setState(() {
      _isLoading = true;
    });

    String fileName = __image.path.split('/').last;

    var formData = FormData.fromMap({
      'id': idUser,
      'foto': await MultipartFile.fromFile(__image.path, filename: fileName),
      'username' : Username,
    });

    blocProfile.bloc.doUpdatePictBloc(formData, (callback){
      DefaultModel model = callback;
      String _Message;
      setState(() {
        _isLoading = false;
        print(model.status);
        if(model.error == false)
        {
          _Message = "Sukses";
        }
        else
        {
          _Message = "Gagal";
        }
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            _Message,
          ),
          duration: Duration(seconds: 2),
        ));

//        showErrorMessage(context, model.message, model.error);
      });
    });

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






