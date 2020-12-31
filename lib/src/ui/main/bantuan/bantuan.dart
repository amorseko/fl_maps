import 'dart:io';
import 'dart:async';
import 'package:fl_maps/src/ui/main/bantuan/list_bantuan.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:fl_maps/src/model/default_model.dart';
import 'package:fl_maps/src/bloc/submit_bantuan_bloc.dart';
import 'package:fl_maps/src/ui/main/main_page.dart';
import 'package:fl_maps/src/model/model_gapoktan.dart';
import 'package:fl_maps/src/bloc/bloc-gapoktan-cmb.dart';
import 'package:fl_maps/src/bloc/bloc_jenis_bantuan.dart';
import 'package:fl_maps/src/model/model_jenis_bantuan.dart';

class BantuanPage extends StatefulWidget {
  @override
  _BantuanPage createState() => _BantuanPage();
}

class jenisBantuan {
  const jenisBantuan(this.jenisbantuan);

  final String jenisbantuan;
}

class _BantuanPage extends State<BantuanPage> {
  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();

  File _image;
//  final _gapoktan = TextEditingController();
  final _spesifikasi = TextEditingController();
  final _tahun = TextEditingController();
  final _jumlah = TextEditingController();
  final _kapasitas = TextEditingController();
  final _kondisi = TextEditingController();
  final _asalDana = TextEditingController();
  final _foto = TextEditingController();
  TextEditingController _date = new TextEditingController();

  Location _locationTracker = Location();
  LatLng _latlng;

  DateTime selectedDate = DateTime.now();
  String valueDate;

  String _jenisBantuanSelected;

  String _selectedGapoktan;


  GetModelGapoktan _MdlGapoktan = GetModelGapoktan();
  GetListJenisBantuanModel _MdlJenisBantuan = GetListJenisBantuanModel();

  final listGapoktanBloc = GetListGapoktanCmbBloc();
  final listJenisBantuanBloc = JenisBantuanBloc();




  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _attempGapoktan();
    _attempJenisBantuan();
    _inivtiew();
  }

  _inivtiew() async {
    getCurrentLocation();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        title: TextWidget(txt: "Bantuan", color: colorTitle()),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: ProgressDialog(
        inAsyncCall: _isLoading,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child:  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: TextWidget(
                        txtSize: 12,
                        txt : "Pilih Kelompok Tani",
                      ),
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGapoktan = newValue;
                        });
                      },
                      value: _selectedGapoktan,
                      items: _MdlGapoktan.data == null ? List<String>()
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Text(value,
                                style: TextStyle(fontSize: 12)
                            )
                        );
                      }).toList()
                          : _MdlGapoktan.data
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                            value: value.id_gapoktan,
                            child: Text(
                              value.gapoktan,
                              style: TextStyle(fontSize: 12),
                            ));
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child:  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: TextWidget(
                        txtSize: 12,
                        txt : "Pilih Jenis Bantuan",
                      ),
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          _jenisBantuanSelected = newValue;
                        });
                      },
                      value: _jenisBantuanSelected,
                      items: _MdlJenisBantuan.data == null ? List<String>()
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Text(value,
                                style: TextStyle(fontSize: 12)
                            )
                        );
                      }).toList()
                          : _MdlJenisBantuan.data
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                            value: value.id,
                            child: Text(
                              value.name,
                              style: TextStyle(fontSize: 12),
                            ));
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _spesifikasi,
                    decoration: InputDecoration(
                      labelText: "Spesifikasi",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _tahun,
                    decoration: InputDecoration(
                      labelText: "Tahun",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: _jumlah,
                    decoration: InputDecoration(
                      labelText: "Jumlah",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _kapasitas,
                    decoration: InputDecoration(
                      labelText: "Kapasitas",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _kondisi,
                    decoration: InputDecoration(
                      labelText: "Kondisi",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _asalDana,
                    decoration: InputDecoration(
                      labelText: "Asal Dana",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () => {_selectDate(context)},
                        child: TextFormField(
                          enabled: false,
                          controller: _date,
                          decoration: InputDecoration(labelText: "Tanggal"),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () => {_showPicker(context)},
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(labelText: "Foto"),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: _image == null
                      ? Text("No Selected Image")
                      : Image.file(
                          _image,
                          width: MediaQuery.of(context).size.width,
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
                          txt: "SAVE",
                          txtSize: 14.0,
                        ),
                        elevation: 4.0,
                        color: primaryColor,
                        splashColor: hintColor,
                        onPressed: () {
                          saveData();
                          // if (_formKey.currentState.validate()) {
                          //   Scaffold.of(context).showSnackBar(
                          //       SnackBar(content: Text('Processing Data')));
                          // }
                        },
                      ),
                      height: 50.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // _buildImage(_images) {
  //   if (_images != "") {
  //     return Container(
  //       child: Image(
  //         image: _images,
  //       ),
  //       alignment: FractionalOffset.topCenter,
  //       decoration: BoxDecoration(color: Colors.transparent),
  //     );
  //   } else {
  //     return Divider(color: Colors.white, height: 0.0);
  //   }
  // }

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
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

//  Future getImage() async {
//    print("onpressed");
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//    setState(() {
//      _image = image;
//      print("this is a image path : ${_image.path}");
//      // _foto.value = TextEditingValue(text: _image.toString());
//    });
//  }

  _attempGapoktan() {
    var params = {
      "id_gapoktan" : "",
      "id_kota" : "",
      "id_provinsi" : "",
    };
    listGapoktanBloc.getListGapoktanBlocCmb(params,(model) => {
      getGapoktanData(model),
    });
  }

  getGapoktanData(model) {
    setState(() {
      _MdlGapoktan = model;
    });
  }

  _attempJenisBantuan() {
    listJenisBantuanBloc.JenisBantuanBlocs((model) => {
      getJenisBantuan(model),
    });
  }

  getJenisBantuan(model) {
    setState(() {
      _MdlJenisBantuan = model;
    });
  }


  saveData() async {
    setState(() {
      _isLoading = true;
    });

    _locationTracker.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 0, distanceFilter: 0);
    var posisi = await _locationTracker.getLocation();
    String lokasiBantuan =
        posisi.latitude.toString() + ", " + posisi.longitude.toString();
    String fileName = _image.path.split('/').last;
    var dateSplit = valueDate.split("-");
//    print(dateSplit[0]);
    String tanggal = "${dateSplit[2]}-${dateSplit[1]}-${dateSplit[0]}";
    print(tanggal);
    var formData = FormData.fromMap({
      'gapoktan': _selectedGapoktan,
      'jenis_bantuan': _jenisBantuanSelected,
      'spesifikasi': _spesifikasi.text,
      'tahun': _tahun.text,
      'jumlah': _jumlah.text,
      'kapasitas': _kapasitas.text,
      'kondisi': _kondisi.text,
      'asal_dana': _asalDana.text,
      'tanggal': tanggal,
      'foto': await MultipartFile.fromFile(_image.path, filename: fileName),
      'gps_tag': lokasiBantuan,
      'mode':'insert',
    });

    bloc.doBantuan(formData, (callback) {
      DefaultModel model = callback;
      print(model);
//      print(model.message);

      setState(() {
        _isLoading = false;
        print(model.status);
        showErrorMessage(context, model.message, model.error);
      });


      // if (model.status == "success") {
      // Scaffold.of(context).showSnackBar(SnackBar(content: Text(model.message)));
      // } else {
      //   Scaffold.of(context).showSnackBar(
      //                           SnackBar(content: Text(model.message)));
      // }
    });
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
                                      clearfield();
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, "/list_bantuan", (_) => false);
//                                      Navigator.of(context).pushReplacement(new MaterialPageRoute(settings: const RouteSettings(name: '/list_bantuan'), builder: (context) => new ListBantuanPage()));
//                                      routeToWidget(context, MainPage())
//                                          .then((value) {
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

  void getCurrentLocation() async {
    _locationTracker.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 0, distanceFilter: 0);
    var posisi = await _locationTracker.getLocation();
    print("Lokasi : " +
        posisi.latitude.toString() +
        "," +
        posisi.longitude.toString());
  }


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        valueDate =
            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
        _date.value = TextEditingValue(text: valueDate.toString());
      });
  }

  void clearfield() {
    _selectedGapoktan = "";
    _spesifikasi.clear();
    _tahun.clear();
    _jumlah.clear();
    _kapasitas.clear();
    _kondisi.clear();
    _asalDana.clear();
    _foto.clear();
    _jenisBantuanSelected = null;
    _image = null;
  }
}
