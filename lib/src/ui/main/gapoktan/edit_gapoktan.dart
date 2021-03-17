import 'dart:async';

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
import 'package:fl_maps/src/bloc/bloc_get_data_gapoktan.dart';
import 'package:fl_maps/src/model/model_edit_gapoktan.dart';
import 'package:fl_maps/src/bloc/request/do_req_delete_gapoktan.dart';
import 'package:fl_maps/src/bloc/request/do_req_gapoktan.dart';
import 'package:fl_maps/src/bloc/bloc_insert_gapoktan.dart' as insertGapoktan;
import 'package:fl_maps/src/bloc/bloc_list_kota.dart' as blocKota;
import 'package:fl_maps/src/model/model_list_kota.dart';

import '../main_page.dart';

class EditGapoktanPage extends StatefulWidget {
  String idGapoktan;
  @override
  _EditGapoktanPage createState() => _EditGapoktanPage();
  EditGapoktanPage({this.idGapoktan});
}

class _EditGapoktanPage extends State<EditGapoktanPage> {
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

  String selectedProvinsi, selectedMasterKomoditi,selectedKota;



  GetListModelProvinsi _Provinsi = GetListModelProvinsi();
  GetListModelMasterKomoditi _MasterKomoditi = GetListModelMasterKomoditi();
  GetListKotaModels _Kota = GetListKotaModels();


  final listProvinsiBloc = GetListProvinsiBloc();
  final listMasterKomoditiBloc = GetListMasterKomoditiBloc();

  @override
  void initState() {
    getDataSelected();
    _AttempMasterKomoditi();
    _AttempProvinsi();
    String dataEmpty = "";
    _attempNamaKota(dataEmpty);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        title: TextWidget(txt: "Edit Kelompok Petani", color: colorTitle()),
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

  getDataSelected() async {
    String DataIdKota = "";
    reqDelGapoktan request = reqDelGapoktan (
      id_gapoktan: widget.idGapoktan
    );

    await bloc.doGetDataGapoktan(request.toMap(), (status, error, message, model) {
      GetModelEditGapoktan _GapoktanData = model;
      setState(() {
        selectedMasterKomoditi = _GapoktanData.data[0].id_komoditi;
        selectedProvinsi = _GapoktanData.data[0].id_provinsi;
        _NamaProduct.text = _GapoktanData.data[0].nama_produk;
        _Namagapoktan.text = _GapoktanData.data[0].nama_gapoktan;
        _Alamat.text = _GapoktanData.data[0].alamat;
        _NamaPic.text = _GapoktanData.data[0].nama_pic;
        _NoPic.text = _GapoktanData.data[0].no_pic;
        _JenisProduct.text = _GapoktanData.data[0].jenis_produk;
        _Kapasitas.text = _GapoktanData.data[0].kapasitas;
        _Pasar.text = _GapoktanData.data[0].pasar;
        _Kemitraan.text = _GapoktanData.data[0].kemitraan;
//        selectedKota = _GapoktanData.data[0].id_kota;
//        print(_GapoktanData.data[0].id_kota);

        Timer(Duration(seconds: 1), () {
          _attempNamaKota(selectedProvinsi);
          selectedKota = _GapoktanData.data[0].id_kota;
        });
        _isAsync = false;
      });
    });
  }

  _simpanData() {
    if(selectedMasterKomoditi != "" || selectedProvinsi != "" || _Namagapoktan.text != "" || _Alamat.text != "" || _NamaPic.text != "" || _NoPic.text != "" || _JenisProduct.text != "" ||_Pasar.text != "" || _Kemitraan.text != "") {
      setState(() {
        _isAsync = true;
      });
      doReqGapoktan request = doReqGapoktan(
        id_gapoktan: widget.idGapoktan,
        komoditi: selectedMasterKomoditi,
        provinsi: selectedProvinsi,
        id_kota: selectedKota,
        nama_gapoktan: _Namagapoktan.text,
        alamat: _Alamat.text,
        nama_pic: _NamaPic.text,
        no_pic: _NoPic.text,
        jenis_produk: _JenisProduct.text,
        pasar: _Pasar.text,
        kapasitas: _Kapasitas.text,
        kemitraan: _Kemitraan.text,
        nama_produk: _NamaProduct.text,
        mode : "edit",
      );

      print(request.toMap());



      insertGapoktan.bloc.actInsertGapoktan(request.toMap(),  (status, message) => {
        setState(() {
          showErrorMessage(context, message, status);
          _isAsync = false;
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

                                      Navigator.pushNamedAndRemoveUntil(
                                          context, "/list_gapoktan", (_) => false);
                                    } else {
                                      Navigator.of(context).pop();
                                    }

//                                    Navigator.of(
//                                        context)
//                                        .pushAndRemoveUntil(
//                                        MaterialPageRoute(
//                                            builder: (context) =>
//                                                ListGapoktanPage()),
//                                            (Route<dynamic> route) =>
//                                        true);
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

