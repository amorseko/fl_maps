import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fl_maps/src/bloc/bloc-gapoktan-cmb.dart';
import 'package:fl_maps/src/model/member_model.dart';
import 'package:fl_maps/src/model/model_gapoktan.dart';
import 'package:fl_maps/src/utility/Sharedpreferences.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fl_maps/src/bloc/submit_data_kinerja.dart';
import 'package:fl_maps/src/model/default_model.dart';
//import 'package:fl_maps/src/model/model_jenis_bantuan_flag.dart';
//import 'package:fl_maps/src/bloc/bloc_jenis_bantuan_flag.dart';
import 'package:fl_maps/src/model/model_master_jenis_bantuan.dart';
import 'package:fl_maps/src/bloc/bloc_list_master_jenis_bantuan.dart';

class KinerjaOnlyPage extends StatefulWidget {
  @override
  _KinerjaOnlyPage createState() => _KinerjaOnlyPage();
}

class KondisiAlat {
  const KondisiAlat(this.id,this.name);

  final String name;
  final String id;
}

class _KinerjaOnlyPage extends State<KinerjaOnlyPage> {

  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  String _jenisBantuanSelected;

  String _selectedGapoktan;
  int _Total;
  DateTime selectedDate = DateTime.now();
  String valueDate;

  String Username, id_gapoktan, id_provinsi, id_kota;

  File _image;

  KondisiAlat selectedKondisiAlat;

  final _BentukHasilOlahan = TextEditingController();
  final _JumlahDiOlah = TextEditingController();
  final _JumlahHasilOlahan = TextEditingController();
  final _JumlahDiJual = TextEditingController();
  final _BiayaDiolah = TextEditingController();
  final _JumlahPenjualan = TextEditingController();
  final _PenghasilanJasaAlat = TextEditingController();
  final _UangKas = TextEditingController();
  final _HargaProduk = TextEditingController();
  final _Keterangan = TextEditingController();
  TextEditingController _date = new TextEditingController();

  List<KondisiAlat> kondisialats = <KondisiAlat>[const KondisiAlat('Normal','Normal'), const KondisiAlat('Rusak Ringan','Rusak Ringan'),const KondisiAlat('Rusak Berat','Rusak Berat')];


  GetModelGapoktan _MdlGapoktan = GetModelGapoktan();
  GetListMasterJenisBantuan _MdlJenisBantuan = GetListMasterJenisBantuan();

  final listGapoktanBloc = GetListGapoktanCmbBloc();
  final listJenisBantuanBloc = ListMasterJenisBantuanBloc();

  @override
  void initState() {
    super.initState();
    _isLoading = false;

    _attempJenisBantuan();


    SharedPreferencesHelper.getDoLogin().then((member) async {
      print("data member : $member");
      final memberModels = MemberModels.fromJson(json.decode(member));
      setState(() {
        Username = memberModels.data.username;
        id_provinsi = memberModels.data.id_provinsi;
        id_kota = memberModels.data.id_kota;
        id_gapoktan = memberModels.data.id_gapoktan;

      });
      _attempGapoktan(id_gapoktan,id_kota,id_provinsi);


    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        title: TextWidget(txt: "Kinerja", color: colorTitle()),
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
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _BentukHasilOlahan,
                    decoration: InputDecoration(
                      labelText: "Bentuk hasil olahan",
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
                    controller: _JumlahDiOlah,
                    decoration: InputDecoration(
                      labelText: "Jumlah Diolah",
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
                    controller: _JumlahHasilOlahan,
                    decoration: InputDecoration(
                      labelText: "Jumlah Hasil Olahan",
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
                    onChanged: (text) {
                      calcJunlahPenjualan();
                    },
                    keyboardType: TextInputType.number,
                    controller: _JumlahDiJual,
                    decoration: InputDecoration(
                      labelText: "Jumlah Dijual",
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
                    onChanged: (text) {
                      calcJunlahPenjualan();
                    },
                    keyboardType: TextInputType.number,
                    controller: _HargaProduk,
                    decoration: InputDecoration(
                      labelText: "Harga produk",
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
                    onChanged: (text) {
                      calcJunlahPenjualan();
                    },
                    keyboardType: TextInputType.number,
                    controller: _BiayaDiolah,
                    decoration: InputDecoration(
                      labelText: "Biaya yang diolah",
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
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: _JumlahPenjualan,
                    decoration: InputDecoration(
                      labelText: "Jumlah Penjualan",
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
                    controller: _PenghasilanJasaAlat,
                    decoration: InputDecoration(
                      labelText: "Penghasilan jasa alat",
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
                    controller: _UangKas,
                    decoration: InputDecoration(
                      labelText: "Uang kas",
                    ),
                  ),
                ),
                //here combobox kondisi alat
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child:  DropdownButtonHideUnderline(
                    child: DropdownButton<KondisiAlat>(
                      hint: TextWidget(
                        txtSize: 12,
                        txt : "Pilih Kondisi Alat",
                      ),
                      isExpanded: true,
                      onChanged: (KondisiAlat newValue) {
                        setState(() {
                          //_KondisiAlat = newValue;
                          selectedKondisiAlat = newValue;
                        });

                      },
                      value: selectedKondisiAlat,
                      items: kondisialats.map((KondisiAlat kondisialat) {
                        return new DropdownMenuItem<KondisiAlat>(
                          value: kondisialat,
                          child: new Text(
                            kondisialat.name,
                            style: new TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
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
                    keyboardType: TextInputType.multiline,
                    controller: _Keterangan,
                    decoration: InputDecoration(
                      labelText: "Keterangan",
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

  calcJunlahPenjualan()
  {
    int _HargaProduks = int.parse(_HargaProduk.text);
    int _JunlahDijuals = int.parse(_JumlahDiJual.text);
     _Total = (_JunlahDijuals * _HargaProduks) - (int.parse(_BiayaDiolah.text));
     _JumlahPenjualan.text = "Rp " + _Total.toString();
    print(_Total);

  }

  saveData() async {
    setState(() {
      _isLoading = true;
    });


    String fileName = _image.path.split('/').last;


    var formData = FormData.fromMap({
      'id_gapoktan': _selectedGapoktan,
      'id_jenis_bantuan': _jenisBantuanSelected,
      'tanggal': _date.text,
      'bentuk_hasil_olahan': _BentukHasilOlahan.text,
      'jumlah_diolah': _JumlahDiOlah.text,
      'jumlah_hasil_olahan': _JumlahHasilOlahan.text,
      'jumlah_dijual': _JumlahDiJual.text,
      'harga_produk': _HargaProduk.text,
      'biaya_olah': _BiayaDiolah.text,
      'jumlah_penjualan': _JumlahPenjualan.text,
      'penghasilan_jasa_alat': _PenghasilanJasaAlat.text,
      'uang_kas': _UangKas.text,
      'kondisi_alat': selectedKondisiAlat.id,
      'foto': await MultipartFile.fromFile(_image.path, filename: fileName),
      'user_input': Username,
      'keterangan': _Keterangan.text,
      'mode':'insert',
    });

    bloc.doDatakinerjaBloc(formData,(callback){
      DefaultModel model = callback;

      print(model);

      setState(() {
        _isLoading = false;
        print(model.status);
        showErrorMessage(context, model.message, model.error);
      });

    });


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
                                          context, "/list_kinerja_only", (_) => false);
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

  _attempGapoktan(String _idGapoktan, String _idKota, String _idProvinsi) {
    var params = {
      "id_gapoktan" : _idGapoktan,
      "id_kota" : _idKota,
      "id_provinsi" : _idProvinsi,
    };
    print(params);
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
      "id" : "",
    };

    listJenisBantuanBloc.getListMasterJenisBantuan((model) {
      getJenisBantuan(model);
    });
  }
  getJenisBantuan(model) {
    setState(() {
      _MdlJenisBantuan = model;
    });
  }




  void clearfield() {
    _selectedGapoktan = "";
    _JumlahDiJual.clear();
    _JumlahHasilOlahan.clear();
    _JumlahDiOlah.clear();
    _BentukHasilOlahan.clear();
    _jenisBantuanSelected = "";
    _BiayaDiolah.clear();
    _JumlahPenjualan.clear();
    _PenghasilanJasaAlat.clear();
    _UangKas.clear();
    _HargaProduk.clear();
    _Keterangan.clear();
//    _jenisBantuanSelected = null;
    _image = null;
  }
}