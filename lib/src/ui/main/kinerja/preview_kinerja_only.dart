import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_maps/src/utility/Colors.dart';
import 'package:fl_maps/src/widgets/ProgressDialog.dart';
import 'package:fl_maps/src/widgets/TextWidget.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:fl_maps/src/model/model_data_kinerja.dart';
import 'package:fl_maps/src/bloc/bloc_list_data_kinerja.dart';

class PreviewKinerjaOnlyPage extends StatefulWidget {
  String id_kinerja;
  @override
  _PreviewKinerjaOnlyPage createState() => _PreviewKinerjaOnlyPage();
  PreviewKinerjaOnlyPage({this.id_kinerja});
}



class _PreviewKinerjaOnlyPage extends State<PreviewKinerjaOnlyPage> {

  String StringImage;
  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String valueDate;

  String Username;

  File _image;


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
  final _KondisiAlat = TextEditingController();
  final _NamaGapoktan = TextEditingController();
  final _NamaJenisBantuan = TextEditingController();
  final _UserInput = TextEditingController();

  TextEditingController _date = new TextEditingController();


  final blocListKinerja = ListDataKinerjaBloc();

  @override
  void initState() {
    super.initState();

    initView();
  }

  initView () async {
    var data = {
      "id": widget.id_kinerja
    };
    print(data);

    await blocListKinerja.getListDataKinerja(data, (status, error, message, model) {

      GetModelDataKinerja dataM = model;
      var _ResultSplitTanggal;
      print("data nama gapoktan : "  + dataM.data[0].nama_gapoktan);
      setState(() {
        _NamaGapoktan.text = dataM.data[0].nama_gapoktan;
        _NamaJenisBantuan.text = dataM.data[0].nama_bantuan;
        _date.text = dataM.data[0].tanggal;
        _ResultSplitTanggal = dataM.data[0].tanggal.split("-");
        _date.text = _ResultSplitTanggal[2] + "-" + _ResultSplitTanggal[1] + "-" + _ResultSplitTanggal[0];
        _BentukHasilOlahan.text = dataM.data[0].bentuk_hasil_olahan;
        _JumlahDiOlah.text = dataM.data[0].jumlah_diolah;
        _JumlahHasilOlahan.text = dataM.data[0].jumlah_hasil_olahan;
        _JumlahDiJual.text = dataM.data[0].jumlah_dijual;
        _HargaProduk.text = dataM.data[0].harga_produk;
        _BiayaDiolah.text = dataM.data[0].biaya_olah;
        _JumlahPenjualan.text = dataM.data[0].jumlah_penjualan;
        _PenghasilanJasaAlat.text = dataM.data[0].penghasilan_jasa_alat;
        _UangKas.text = dataM.data[0].uang_kas;
        _UserInput.text = dataM.data[0].user_input;
        _Keterangan.text = dataM.data[0].keterangan;
        StringImage = dataM.data[0].foto;
        _KondisiAlat.text = dataM.data[0].kondisi_alat;
        getImages(dataM.data[0].foto);

      });


    });

    setState(() {
      _isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        title: TextWidget(txt: "Preview Data Kinerja", color: colorTitle()),
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    readOnly: true,
                    controller: _NamaGapoktan,
                    decoration: InputDecoration(
                      labelText: "Nama Kelompok Tani",
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
                    controller: _NamaJenisBantuan,
                    decoration: InputDecoration(
                      labelText: "Nama Jenis Bantuan",
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
                    controller: _date,
                    decoration: InputDecoration(
                      labelText: "Tanggal",
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
                    readOnly: true,
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
                    readOnly: true,
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

                    readOnly: true,
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

                    readOnly: true,
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

                    readOnly: true,
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
                    readOnly: true,
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
                    readOnly: true,
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
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: _KondisiAlat,
                    decoration: InputDecoration(
                      labelText: "Kondisi Alat",
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
                    controller: _UserInput,
                    decoration: InputDecoration(
                      labelText: "User Input",
                    ),
                  ),
                ),
//                for list foto here
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 0.0),
                    child: _image != null && StringImage != ""
                        ? Image.network(StringImage, width: MediaQuery.of(context).size.width)//Text("No Selected Image")
                        : (_image != null && StringImage == "")
                        ? Image.file(_image,  width: MediaQuery.of(context).size.width,)
                        : Text("No Selected Image")
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
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Keterangan",
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
}