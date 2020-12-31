import 'package:json_annotation/json_annotation.dart';

part 'model_data_kinerja.g.dart';

@JsonSerializable(nullable: true)
class GetModelDataKinerja {
  String status;
  bool error;
  String message;
  List<ListDataKinerja> data = [];

  GetModelDataKinerja({this.status,this.error, this.message, this.data});

  factory GetModelDataKinerja.fromJson(Map<String, dynamic> json) =>
      _$GetModelDataKinerjaFromJson(json);

  Map<String, dynamic> toJson() => _$GetModelDataKinerjaToJson(this);

  GetModelDataKinerja.withError(String error)
      : message = error,
        error = false;


}

@JsonSerializable(nullable: true)
class ListDataKinerja {

  ListDataKinerja(
      {
        this.id_kinerja,
        this.id_gapoktan,
        this.id_jenis_bantuan,
        this.tanggal,
        this.bentuk_hasil_olahan,
        this.jumlah_diolah,
        this.jumlah_hasil_olahan,
        this.jumlah_dijual,
        this.harga_produk,
        this.biaya_olah,
        this.jumlah_penjualan,
        this.penghasilan_jasa_alat,
        this.uang_kas,
        this.kondisi_alat,
        this.foto,
        this.user_input,
        this.keterangan,
        this.tanggal_input,
        this.tanggal_modify,
        this.nama_gapoktan,
        this.nama_bantuan,
      }
      );

  @JsonKey(name: 'id_kinerja')
  String id_kinerja;

  @JsonKey(name: 'id_gapoktan')
  String id_gapoktan;

  @JsonKey(name: 'id_jenis_bantuan')
  String id_jenis_bantuan;

  @JsonKey(name: 'tanggal')
  String tanggal;

  @JsonKey(name: 'bentuk_hasil_olahan')
  String bentuk_hasil_olahan;

  @JsonKey(name: 'jumlah_diolah')
  String jumlah_diolah;

  @JsonKey(name: 'jumlah_hasil_olahan')
  String jumlah_hasil_olahan;

  @JsonKey(name: 'jumlah_dijual')
  String jumlah_dijual;

  @JsonKey(name: 'harga_produk')
  String harga_produk;

  @JsonKey(name: 'biaya_olah')
  String biaya_olah;

  @JsonKey(name: 'jumlah_penjualan')
  String jumlah_penjualan;

  @JsonKey(name: 'penghasilan_jasa_alat')
  String penghasilan_jasa_alat;

  @JsonKey(name: 'uang_kas')
  String uang_kas;

  @JsonKey(name: 'kondisi_alat')
  String kondisi_alat;

  @JsonKey(name: 'foto')
  String foto;

  @JsonKey(name: 'user_input')
  String user_input;

  @JsonKey(name: 'keterangan')
  String keterangan;

  @JsonKey(name: 'tanggal_input')
  String tanggal_input;

  @JsonKey(name: 'tanggal_modify')
  String tanggal_modify;

  @JsonKey(name: 'nama_gapoktan')
  String nama_gapoktan;

  @JsonKey(name: 'nama_bantuan')
  String nama_bantuan;

  factory ListDataKinerja.fromJson(Map<String, dynamic> json) => _$ListDataKinerjaFromJson(json);

  Map<String, dynamic> toJson() => _$ListDataKinerjaToJson(this);
}

