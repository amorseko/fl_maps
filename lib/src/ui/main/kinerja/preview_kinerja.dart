import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:fl_maps/src/bloc/bloc-gapoktan-cmb.dart';
import 'package:fl_maps/src/bloc/bloc_jenis_bantuan.dart';
import 'package:fl_maps/src/model/model_gapoktan.dart';
import 'package:fl_maps/src/model/model_jenis_bantuan.dart';
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
import 'package:fl_maps/src/model/model_edit_kinerja.dart';
import 'package:fl_maps/src/bloc/bloc_list_kinerja.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PreviewKinerjaPage extends StatefulWidget {
  String id_kinerja;
  @override
  _PreviewKinerjaPage createState() => _PreviewKinerjaPage();
  PreviewKinerjaPage({this.id_kinerja});
}

class _PreviewKinerjaPage extends State<PreviewKinerjaPage> {

  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  File _image;
  String StringImage;

  final blocListKinerja = ListKinerjaBloc();




  final _kapasitasTerpasang = TextEditingController();
  final _jumlahBB = TextEditingController();
  final _hasilOlahan = TextEditingController();
  final _jumlahOlahan = TextEditingController();
  final _namaGapoktan = TextEditingController();
  final _namaBantuan = TextEditingController();
  final _namaProses = TextEditingController();




  initData() async{

    var data = {
      "id": widget.id_kinerja
    };
    print(data);

    await blocListKinerja.getListKinerja(data, (status, error, message, model) {

      GetModelEditKinerja dataM = model;
      print("data nama gapoktan : "  + dataM.data[0].nama_gapoktan);
      setState(() {
        _namaGapoktan.text = dataM.data[0].nama_gapoktan;
        _namaBantuan.text = dataM.data[0].nama_jenis_bantuan;
        _namaProses.text = dataM.data[0].name_proses;
        _kapasitasTerpasang.text = dataM.data[0].kapasitas_terpasang;
        _jumlahBB.text = dataM.data[0].jumlah_bb;
        _hasilOlahan.text = dataM.data[0].hasil_olahan;
        _jumlahOlahan.text = dataM.data[0].jumlah_olahan;
        StringImage = dataM.data[0].foto;
        getImages(dataM.data[0].foto);

      });


    });

    setState(() {
      _isLoading = false;
    });
  }

  Future getImages(String imageUrl) async {
    var image = await urlToFile(imageUrl);
    print(image);
    setState((){
      _image = image;
    });
  }

  Future<File> urlToFile(String imageUrl) async {
    var rng = new Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = new File('$tempPath'+ (rng.nextInt(100)).toString() +'.png');
    http.Response response = await http.get(imageUrl);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  @override
  void initState() {
    super.initState();

    initData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        title: TextWidget(txt: "Edit Kinerja", color: colorTitle()),
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
                  child: TextFormField(
                    enabled: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _namaGapoktan,
                    decoration: InputDecoration(
                      labelText: "Nama Gapoktan",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: TextFormField(
                    enabled: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _namaBantuan,
                    decoration: InputDecoration(
                      labelText: "Nama Bantuan",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: TextFormField(
                    enabled: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _namaProses,
                    decoration: InputDecoration(
                      labelText: "Nama Proses",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: TextFormField(
                    enabled: false,
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
                    enabled: false,
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
                    enabled: false,
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
                    enabled: false,
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
                    child: _image != null && StringImage != ""
                        ? Image.network(StringImage, width: MediaQuery.of(context).size.width)//Text("No Selected Image")
                        : (_image != null && StringImage == "")
                        ? Image.file(_image,  width: MediaQuery.of(context).size.width,)
                        : Text("No Selected Image")
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }




}
