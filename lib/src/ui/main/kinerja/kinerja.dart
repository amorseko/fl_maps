import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fl_maps/src/bloc/bloc-gapoktan-cmb.dart';
//import 'package:fl_maps/src/bloc/bloc_jenis_bantuan.dart';
import 'package:fl_maps/src/model/model_gapoktan.dart';
//import 'package:fl_maps/src/model/model_jenis_bantuan.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:fl_maps/src/model/model_jenis_proses.dart';
import 'package:fl_maps/src/bloc/bloc_jenis_proses.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:fl_maps/src/bloc/submit_jenis_proses_bloc.dart';
import 'package:fl_maps/src/model/default_model.dart';
import 'package:fl_maps/src/model/model_jenis_bantuan_flag.dart';
import 'package:fl_maps/src/bloc/bloc_jenis_bantuan_flag.dart';

class KinerjaPage extends StatefulWidget {
  @override
  _KinerjaPage createState() => _KinerjaPage();
}

class _KinerjaPage extends State<KinerjaPage> {

  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  String _jenisBantuanSelected;

  String _selectedGapoktan;

  String _selectedJenisProses;
  File _image;


  Location _locationTracker = Location();


  final _kapasitasTerpasang = TextEditingController();
  final _jumlahBB = TextEditingController();
  final _hasilOlahan = TextEditingController();
  final _jumlahOlahan = TextEditingController();


  GetModelGapoktan _MdlGapoktan = GetModelGapoktan();
  GetListJenisBantuanFlagModel _MdlJenisBantuan = GetListJenisBantuanFlagModel();
  GetListJenisProses _MdlJenisProses = GetListJenisProses();

  final listGapoktanBloc = GetListGapoktanCmbBloc();
  final listJenisBantuanBloc = JenisBantuanFlagBloc();
  final listJenisProsesBloc = GetJenisProsesBloc();

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _attempGapoktan();
    _attempJenisBantuan();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.white),
          title: TextWidget(txt: "Kinerja Bantuan", color: colorTitle()),
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
                            txt : "Pilih Gapoktan",
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

                              _selectedJenisProses = null;
                            });

                            _attempJenisProses(_jenisBantuanSelected);
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
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: TextWidget(
                            txt: "Pilih Nama Barang",
                            txtSize: 12,
                          ),
                          isExpanded: true,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedJenisProses = newValue;
                            });
                          },
                          value: _selectedJenisProses,
                          items: _MdlJenisProses.data == null
                              ? List<String>()
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(fontSize: 12)));
                          }).toList()
                              : _MdlJenisProses.data
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
                        controller: _kapasitasTerpasang,
                        decoration: InputDecoration(
                          labelText: "Kapasitas Terpasang",
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
                        controller: _jumlahBB,
                        decoration: InputDecoration(
                          labelText: "Jumlah BB",
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
                        controller: _hasilOlahan,
                        decoration: InputDecoration(
                          labelText: "Hasil Olahan",
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
                        controller: _jumlahOlahan,
                        decoration: InputDecoration(
                          labelText: "Jumlah Olahan",
                        ),
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

  saveData() async {
    setState(() {
      _isLoading = true;
    });

    _locationTracker.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 0, distanceFilter: 0);
    var posisi = await _locationTracker.getLocation();
//    String LokasiKinjera = posisi.latitude.toString() + "||" + posisi.longitude.toString();

    String fileName = _image.path.split('/').last;


    var formData = FormData.fromMap({
      'gapoktan': _selectedGapoktan,
      'jenis_bantuan': _jenisBantuanSelected,
      'jenis_proses': _selectedJenisProses,
      'kapasitas_terpasang': _kapasitasTerpasang.text,
      'jumlah_bb': _jumlahBB.text,
      'hasil_olahan': _hasilOlahan.text,
      'jumlah_olahan': _jumlahOlahan.text,
      'foto': await MultipartFile.fromFile(_image.path, filename: fileName),
      'lat': posisi.latitude.toString(),
      'long' : posisi.longitude.toString(),
      'mode':'insert',
    });

    bloc.doKinerjaBloc(formData,(callback){
      DefaultModel model = callback;

      print(model);

      setState(() {
        _isLoading = false;
        print(model.status);
        showErrorMessage(context, model.message, model.error);
      });

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
                                          context, "/kinerja_page", (_) => false);
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
    var params = {
      "flag_bantuan" : "Y"
    };

    listJenisBantuanBloc.JenisBantuanFlagBlocs(params, (model) => {
      getJenisBantuan(model),
    });

//    listJenisBantuanBloc.JenisBantuanFlagBlocs((params,model) => {
//      getJenisBantuan(model),
//    });
  }

  getJenisBantuan(model) {
    setState(() {
      _MdlJenisBantuan = model;
    });
  }

  _attempJenisProses(val) {
    var data = {
      "id_bantuan": val
    };
//    reqBarang request = reqBarang(id_jenis_part: val);
    listJenisProsesBloc.getListJenisProsesBlocs(
        data,
            (model) => {
              getDataJenisProses(model),
        });
  }

  getDataJenisProses(model) {
    setState(() {
      _MdlJenisProses = model;
    });
  }

  void clearfield() {
    _selectedGapoktan = "";
    _jumlahOlahan.clear();
    _hasilOlahan.clear();
    _jumlahBB.clear();
    _kapasitasTerpasang.clear();
    _selectedJenisProses = "";
    _selectedJenisProses = null;
    _jenisBantuanSelected = "";
//    _jenisBantuanSelected = null;
    _image = null;
  }
}