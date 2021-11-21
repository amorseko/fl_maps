import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' show File, Platform;
import 'package:dio/dio.dart';
import 'package:fl_maps/src/model/default_model.dart';
import 'package:fl_maps/src/model/member_model.dart';
import 'package:fl_maps/src/ui/main/about_us.dart';
import 'package:fl_maps/src/ui/main/bantuan/list_bantuan_new.dart';
import 'package:fl_maps/src/ui/main/gapoktan/maps_page.dart';
import 'package:fl_maps/src/ui/main/kinerja/list_kinerja_only.dart';
import 'package:fl_maps/src/ui/main/list_notif.dart';
import 'package:fl_maps/src/ui/main/pesan.dart';
import 'package:fl_maps/src/ui/main/settings/settings_page.dart';
import 'package:fl_maps/src/ui/pre_login.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/utility/Sharedpreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:fl_maps/src/ui/main/maps/page_maps.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_maps/src/ui/main/gapoktan/list_gapoktan.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fl_maps/src/bloc/doUpdatePictBloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_maps/src/bloc/bloc_fcm.dart' as blocFCM;


Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) {

}


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

final Map<String, Item> _items = <String, Item>{};
Item _itemForMessage(Map<String, dynamic> message) {
  final dynamic data = message['data'] ?? message;
  final String itemId = data['id'];
  final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
    ..status = data['status'];
  return item;
}

class Item {
  Item({this.itemId});
  final String itemId;

  StreamController<Item> _controller = StreamController<Item>.broadcast();
  Stream<Item> get onChanged => _controller.stream;

  String _status;
  String get status => _status;
  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {

  }
}

class _MainPageState extends State<MainPage> {
  bool _isLoading = true;
  String _fullname, _id, _pict, _image, _username;
  File _images;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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


  @override
  void initState() {
    super.initState();
    initView();
    //_registerOnFirebase();

//    LocalNotification().notificationHandler(context);
    getMessage();
    _isLoading = false;
  }


  initView() async{

//    _logout();
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    bool CheckValue = sharedPrefs.containsKey('listgapoktan');

    if(CheckValue) {
      sharedPrefs.remove('listgapoktan');
      //sharedPrefs.clear();
    }

    SharedPreferencesHelper.getDoLogin().then((member) async {
      print("data member : $member");

//      if(member == "" || member == null)
//      {
//        _logout();
//      }
      final memberModels = MemberModels.fromJson(json.decode(member));
      setState(() {
        _fullname = memberModels.data.name;
        _id = memberModels.data.id;
        _pict = memberModels.data.pict;
        _image = memberModels.data.images;
        _username = memberModels.data.username;

        if(_id != null)
        {
          _firebaseMessaging.subscribeToTopic('all');
          _firebaseMessaging.getToken().then((token) {
            var data = {
              'token' : token,
              'id' : _id
            };
            print(data);
            blocFCM.bloc.actUpdateToken(data,(status, message) => {
              print("result update :" + message)
            });

            print(token);
          });
        }

      });

      print("data image $_image");
    });
  }

  Widget _buildCustomCover(Size screenSize) {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        height: screenSize.height / 4,
        width: screenSize.width,
        color: primaryColor,
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/bg_header.png"),
        ),
      ),
    );
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
      _id == null ? "ASIAPP" : _fullname,
      style: _nameTextStyle,
    );
  }

  Widget _boxMenu(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            crossAxisCount: 1,
            childAspectRatio: 1.0 / 0.3,
            padding: const EdgeInsets.all(10),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            children: [
              {
                "icon": "assets/icons/icons_peserta.png",
                "title": "BANTUAN",
                "type": "page",
                "page": ListBantuanNewPage(),
                "status": _id == null ? false : true,
                "color": 0xFF74b9ff
              },
              {
                "icon": "assets/icons/icon_maps_bantuan.png",
                "title": "MAP",
                "type": "page",
                "page": MapsPage(),
                "status": true,
                "color": 0xFFFE5661
              },
              {
                "icon": "assets/icons/icon_maps_bantuan.png",
                "title": "MAP KELOMPOK TANI",
                "type": "page",
                "page": MapsGapoktanPage(),
                "status": false,
                "color": 0xFFfd79a8
              },
              {
                "icon": "assets/icons/icons_riwayat.png",
                "title": "KELOMPOK TANI",
                "type": "page",
                "page": ListGapoktanPage(),
                "status": false,
                "color": 0xFFFF9CA24
              },
              {
                "icon": "assets/icons/icon_kinerja.png",
                "title": "KINERJA BANTUAN",
                "type": "page",
                "page": ListKinerjaOnlyPage(),
                "status": _id == null ? false : true,
                "color": 0xFF3498DB
              },
              {
                "icon": "assets/icons/icons_syaratketentuan.png",
                "title": "LOGIN",
                "type": "page",
                "page": PreLoginActivity(),
                "status": _id == null ? true : false,
                "color": 0xFF3498DB
              },
              {
                "icon": "assets/icons/icon_pesan.png",
                "title": "PESAN",
                "type": "page",
                "page": PesanPage(),
                "status": _id == null ? false : true,
                "color": 0xFFe17055
              },
              {
                "icon": "assets/icons/icon_information.png",
                "title": "INFORMATION",
                "type": "page",
                "page": AboutUS(),
                "status": true,
                "color": 0xFF80E1D1
              },
            ].where((menu) => menu['status'] == true).map((listMenu) {
              return GestureDetector(
                  onTap: () {
                    if (listMenu['type'] == 'call') {
                      MakeCall(context, listMenu['page']);
                    } else if (listMenu['type'] == 'url') {
//                      _fetchGuideBook();
                    } else {
                      routeToWidget(context, listMenu['page']).then((value) {
                        setPotrait();
                      });
                    }
                  },
                  child: Card(
                      color: Color(listMenu["color"]),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Image.asset(
                              listMenu['icon'],
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height / 15,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              txt: listMenu['title'],
                              txtSize: 12,
                              color: Colors.white,
                            )
                          ],
                        ),
                      )));
            }).toList()));
  }

//  Widget _bgBox(BuildContext context){
//    return new Container(
//      child: Image.asset(
//        'assets/images/bg_box.png',
//        width: MediaQuery.of(context).size.width,
//      ),
//      alignment: FractionalOffset.topCenter,
//      decoration: BoxDecoration(color: Colors.transparent),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: ProgressDialog(
          inAsyncCall: _isLoading,
          child: SingleChildScrollView(
              child: Stack(
              children: <Widget>[
                _buildCustomCover(screenSize),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50.0, right: 10.0),
                      child: Align(
                        alignment: FractionalOffset.topRight,
                        child: RawMaterialButton(
                          elevation: 10,
                          shape: new CircleBorder(),
                          child: Image(
                            image: AssetImage("assets/icons/ic_notif_flat.png"),
                            height: 30,
                          ),
                          padding: EdgeInsets.all(5),
                          fillColor: Colors.white,
                          onPressed: () {
                            //                        _logout();
                            if(_id==null)
                            {

                            }
                            else
                            {

                              routeToWidget(context, new ListNotifPage());
                            }
                          },
                        ),
                      ),

                    ),

                  ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0, left: 10.0),
                    child: Align(
                      alignment: FractionalOffset.topLeft,
                      child: RawMaterialButton(
                        elevation: 10,
                        shape: new CircleBorder(),
                        child: Image(
                          image: AssetImage("assets/icons/icon_settings.png"),
                          height: 30,
                        ),
                        padding: EdgeInsets.all(5),
                        fillColor: Colors.white,
                        onPressed: () {
                          //                        _logout();
                          if(_id==null)
                          {

                          }
                          else
                          {
                            print("onclick");
                            routeToWidget(context, new SettingsPage());
                          }
                        },
                      ),
                    ),

                  ),

                ),
                  SafeArea(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: screenSize.height / 7),
                        _id != null ? _buildProfileImage() : SizedBox(height: 100,),
                        SizedBox(height: 10),
                        _buildFullName(),
                        _boxMenu(context),
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Card(
                              elevation: 5,
                            ))
                      ],
                    ),
                  ),
              ],
              )
          )
      ),
    );
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
      'id': _id,
      'foto': await MultipartFile.fromFile(__image.path, filename: fileName),
      'username' : _username,
    });

    bloc.doUpdatePictBloc(formData, (callback){
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
