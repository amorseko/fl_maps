import 'package:json_annotation/json_annotation.dart';

part 'model_edit_kinerja.g.dart';

@JsonSerializable(nullable: true)
class GetModelEditKinerja {
  String status;
  bool error;
  String message;
  List<ListKinerjaDataEdit> data = [];

  GetModelEditKinerja({this.status,this.error, this.message, this.data});

  factory GetModelEditKinerja.fromJson(Map<String, dynamic> json) =>
      _$GetModelEditKinerjaFromJson(json);

  Map<String, dynamic> toJson() => _$GetModelEditKinerjaToJson(this);

  GetModelEditKinerja.withError(String error)
      : message = error,
        error = false;


}

@JsonSerializable(nullable: true)
class ListKinerjaDataEdit {

  ListKinerjaDataEdit(
      {
        this.id_kinerja,
        this.nama_gapoktan,
        this.nama_jenis_bantuan,
        this.name_proses,
        this.kapasitas_terpasang,
        this.jumlah_bb,
        this.hasil_olahan,
        this.jumlah_olahan,
        this.tanggal_input,
        this.foto,
        this.user_input,
        this.id_gapoktan,
        this.id_jenis_bantuan,
        this.id_jenis_proses
      }
      );

  @JsonKey(name: 'id_kinerja')
  String id_kinerja;

  @JsonKey(name: 'nama_gapoktan')
  String nama_gapoktan;

  @JsonKey(name: 'nama_jenis_bantuan')
  String nama_jenis_bantuan;

  @JsonKey(name: 'name_proses')
  String name_proses;

  @JsonKey(name: 'kapasitas_terpasang')
  String kapasitas_terpasang;

  @JsonKey(name: 'jumlah_bb')
  String jumlah_bb;

  @JsonKey(name: 'hasil_olahan')
  String hasil_olahan;

  @JsonKey(name: 'jumlah_olahan')
  String jumlah_olahan;

  @JsonKey(name: 'tanggal_input')
  String tanggal_input;

  @JsonKey(name: 'foto')
  String foto;

  @JsonKey(name: 'user_input')
  String user_input;

  @JsonKey(name: 'id_gapoktan')
  String id_gapoktan;

  @JsonKey(name: 'id_jenis_bantuan')
  String id_jenis_bantuan;

  @JsonKey(name: 'id_jenis_proses')
  String id_jenis_proses;


  factory ListKinerjaDataEdit.fromJson(Map<String, dynamic> json) => _$ListKinerjaDataEditFromJson(json);

  Map<String, dynamic> toJson() => _$ListKinerjaDataEditToJson(this);
}

