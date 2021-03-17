import 'package:fl_maps/src/bloc/request/do_req_delete_komoditi.dart';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:flutter/services.dart';
import 'package:fl_maps/src/model/model_provinsi.dart';
import 'package:fl_maps/src/bloc/bloc-provinsi.dart';
import 'package:fl_maps/src/model/model_master_komoditi.dart';
import 'package:fl_maps/src/bloc/bloc_master_komoditi.dart';
import 'package:fl_maps/src/bloc/request/do_req_gapoktan.dart';
import 'package:fl_maps/src/bloc/bloc_insert_gapoktan.dart';
import 'package:fl_maps/src/bloc/bloc_list_kota.dart' as blocKota;
import 'package:fl_maps/src/model/model_list_kota.dart';

class GapoktanPage extends StatefulWidget {
  @override
  _GapoktanPage createState() => _GapoktanPage();
}

class _GapoktanPage extends State<GapoktanPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isAsync = true;
  final _NamaProduct = TextEditingController();
  final _Namagapoktan = TextEditingController();
  final _Alamat = TextEditingController();
  final _NamaPic = TextEditingController();
  final _NoPic = TextEditingController();
  final _JenisProduct = TextEditingController();
  final _Kapasitas = TextEditingController();
  final _Pasar = TextEditingController();
  final _Kemitraan = TextEditingController();

  String selectedProvinsi, selectedMasterKomoditi, selectedKota;



  GetListModelProvinsi _Provinsi = GetListModelProvinsi();
  GetListModelMasterKomoditi _MasterKomoditi = GetListModelMasterKomoditi();
  GetListKotaModels _Kota = GetListKotaModels();


  final listProvinsiBloc = GetListProvinsiBloc();
  final listMasterKomoditiBloc = GetListMasterKomoditiBloc();


  @override
  void initState() {
    _AttempMasterKomoditi();
    _AttempProvinsi();
    _isAsync = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        title: TextWidget(txt: "Input Kelompok Petani", color: colorTitle()),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: ProgressDialog(
        inAsyncCall: _isAsync,
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
                          txt : "Pilih Komoditi",
                        ),
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            selectedMasterKomoditi = newValue;
                          });
                        },
                        value: selectedMasterKomoditi,
                        items: _MasterKomoditi.data == null ? List<String>()
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(fontSize: 12)
                              )
                          );
                        }).toList()
                            : _MasterKomoditi.data
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
                    child:  DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: TextWidget(
                          txtSize: 12,
                          txt : "Pilih Provinsi",
                        ),
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            selectedProvinsi = newValue;
                          });
                          _attempNamaKota(newValue);
                        },
                        value: selectedProvinsi,
                        items: _Provinsi.data == null ? List<String>()
                              .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value,
                                    style: TextStyle(fontSize: 12)
                                  )
                              );
                        }).toList()
                            : _Provinsi.data
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem(
                              value: value.id_prov,
                              child: Text(
                                value.nama,
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
                          txt : "Pilih Kota",
                        ),
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            selectedKota = newValue;
                          });
//                          _attempNamaKota(newValue);
                        },
                        value: selectedKota,
                        items: _Kota.data == null ? List<String>()
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(fontSize: 12)
                              )
                          );
                        }).toList()
                            : _Kota.data
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem(
                              value: value.id_kota,
                              child: Text(
                                value.nama_kota,
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
                      controller: _NamaProduct,
                      decoration: InputDecoration(
                        labelText: "Nama Product",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 0.0),
                    child: TextFormField(
                      controller: _Namagapoktan,
                      decoration: InputDecoration(
                        labelText: "Nama Kelompok Tani",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 0.0),
                    child: TextFormField(
                      controller: _Alamat,
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      maxLength: 1000,
                      decoration: InputDecoration(
                        labelText: "Alamat",

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 0.0),
                    child: TextFormField(
                      controller: _NamaPic,
                      decoration: InputDecoration(
                        labelText: "Nama PIC",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 0.0),
                    child: TextFormField(
                      controller: _NoPic,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "No. PIC",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 0.0),
                    child: TextFormField(
                      controller: _JenisProduct,
                      decoration: InputDecoration(
                        labelText: "Jenis Product",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 0.0),
                    child: TextFormField(
                      controller: _Kapasitas,
                      decoration: InputDecoration(
                        labelText: "Kapasitas",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 0.0),
                    child: TextFormField(
                      controller: _Pasar,
                      decoration: InputDecoration(
                        labelText: "Pasar",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 0.0),
                    child: TextFormField(
                      controller: _Kemitraan,
                      decoration: InputDecoration(
                        labelText: "Kemitraan",
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
                            txt: "Simpan",
                            txtSize: 14.0,
                          ),
                          elevation: 4.0,
                          color: primaryColor,
                          splashColor: hintColor,
                          onPressed: () {
                            _simpanData();
                          },
                        ),
                        height: 50.0,
                      ),
                    ),
                  ),
                ],
            ),
          ),
        ),
      ),
    );
  }
  _AttempMasterKomoditi() {
    listMasterKomoditiBloc.getListMasterKomoditi((model) => {
      getDataMasterKomoditi(model),
    });
  }

  getDataMasterKomoditi(model) {
    setState(() {
      _MasterKomoditi = model;
    });
  }

  _AttempProvinsi() {
    listProvinsiBloc.getListProvinsi((model) => {
      getDataProvinsi(model),
    });
  }

  getDataProvinsi(model) {
    setState(() {
      _Provinsi = model;
    });
  }

  _attempNamaKota(val) {
    reqDelKomoditi request = reqDelKomoditi(id: val);
    blocKota.bloc.getListNamaParangBlocs(
        request.toMap(),
            (model) => {
              getDataKota(model),
        });
  }

  getDataKota(model) {
    setState(() {
      _Kota = model;
    });
  }


  _simpanData() {
    if(selectedMasterKomoditi != "" || selectedProvinsi != "" || _Namagapoktan.text != "" || _Alamat.text != "" || _NamaPic.text != "" || _NoPic.text != "" || _JenisProduct.text != "" ||_Pasar.text != "" || _Kemitraan.text != "") {

      doReqGapoktan request = doReqGapoktan(
        komoditi: selectedMasterKomoditi,
        provinsi: selectedProvinsi,
        nama_gapoktan: _Namagapoktan.text,
        alamat: _Alamat.text,
        nama_pic: _NamaPic.text,
        no_pic: _NoPic.text,
        jenis_produk: _JenisProduct.text,
        pasar: _Pasar.text,
        kapasitas: _Kapasitas.text,
        kemitraan: _Kemitraan.text,
        nama_produk: _NamaProduct.text,
        mode : "insert",
        id_kota : selectedKota,
      );

      setState(() {
        _isAsync = true;
      });

      bloc.actInsertGapoktan(request.toMap(),  (status, message) => {
        setState(() {
          showErrorMessage(context, message, status);
        })
      });



    } else {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Mohon isi text yang kosong !")));
    }
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
//                                      routeToWidget(context,MainPage()).then((value) {
//                                        setPotrait();
//                                      });
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, "/list_gapoktan", (_) => false);
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
}