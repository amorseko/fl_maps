import 'package:json_annotation/json_annotation.dart';

part 'model_maps_komoditi.g.dart';

@JsonSerializable(nullable: true)
class GetMapsKomoditiModels {
  String status;
  bool error;
  String message;

  List<ListMapsDataKomoditi> data = [];

  GetMapsKomoditiModels(
      {this.status,this.error, this.message, this.data});

  factory GetMapsKomoditiModels.fromJson(Map<String, dynamic> json) =>
      _$GetMapsKomoditiModelsFromJson(json);


  Map<String, dynamic> toJson() => _$GetMapsKomoditiModelsToJson(this);


}

@JsonSerializable(nullable: true)
class ListMapsDataKomoditi {

  ListMapsDataKomoditi(
      {
        this.nama_kegiatan,
        this.komoditi,
        this.spesifikasi,
        this.tahun,
        this.jumlah,
        this.kapasitas,
        this.tahun_pembuatan,
        this.long,
        this.lat,
        this.nama_gapoktan,
        this.nama_produk,
        this.alamat,
        this.nama_pic,
        this.jenis_produk,
        this.jenis_bantuan,
        this.icon,
        this.nama_komoditi,
      }
      );

  @JsonKey(name: 'nama_kegiatan')
  String nama_kegiatan;
  @JsonKey(name: 'komoditi')
  String komoditi;
  @JsonKey(name: 'spesifikasi')
  String spesifikasi;
  @JsonKey(name: 'tahun')
  String tahun;
  @JsonKey(name: 'jumlah')
  String jumlah;
  @JsonKey(name: 'kapasitas')
  String kapasitas;
  @JsonKey(name: 'tahun_pembuatan')
  String tahun_pembuatan;
  @JsonKey(name: 'long')
  String long;
  @JsonKey(name: 'lat')
  String lat;
  @JsonKey(name: 'nama_gapoktan')
  String nama_gapoktan;
  @JsonKey(name: 'nama_produk')
  String nama_produk;
  @JsonKey(name: 'alamat')
  String alamat;
  @JsonKey(name: 'nama_pic')
  String nama_pic;
  @JsonKey(name: 'jenis_produk')
  String jenis_produk;
  @JsonKey(name: 'jenis_bantuan')
  String jenis_bantuan;
  @JsonKey(name: 'icon')
  String icon;
  @JsonKey(name: 'nama_komoditi')
  String nama_komoditi;


  factory ListMapsDataKomoditi.fromJson(Map<String, dynamic> json) => _$ListMapsDataKomoditiFromJson(json);

  Map<String, dynamic> toJson() => _$ListMapsDataKomoditiToJson(this);
}

