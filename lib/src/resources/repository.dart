import 'package:dio/dio.dart';
import 'package:fl_maps/src/model/default_model.dart';
import 'package:fl_maps/src/model/model_maps.dart';
import 'package:fl_maps/src/model/model_gapoktan.dart';
import 'package:fl_maps/src/model/model_provinsi.dart';
import 'package:fl_maps/src/model/model_master_komoditi.dart';
import 'package:fl_maps/src/model/standart_model.dart';
import 'package:fl_maps/src/model/model_jenis_bantuan.dart';
import 'package:fl_maps/src/model/model_list_komoditi.dart';

import 'package:fl_maps/src/resources/api_provider.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<DefaultModel> submitBantuan({FormData formData}) =>
      apiProvider.submitBantuan(formData: formData);

//  Future<GetMapsPartModels> getListMapsDetail() => apiProvider.getListMaps();
  Future<GetMapsPartModels> getListMapsDetail({Map<String, dynamic> body}) =>
      apiProvider.fetchListMaps(body: body);


  Future<GetModelGapoktan> getListGapoktan({Map<String, dynamic> body}) =>
      apiProvider.fetchListGapoktan(body: body);

  Future<GetListModelProvinsi> fetchGetListProvinsi() =>
      apiProvider.fetchListProvinsi();

  Future<GetListModelMasterKomoditi> fetchGetMasterKomoditi() =>
      apiProvider.fetchGetMasterKomoditiApi();

  Future<StandartModels> actInsertGapoktan({Map<String, dynamic> body}) =>
      apiProvider.insertGapoktan(body: body);

  Future<GetListJenisBantuanModel> fetchListJenisBantuan() =>
      apiProvider.fetchListJenisBantuanApi();

  Future<StandartModels> actInsertKomoditi({Map<String, dynamic> body}) =>
      apiProvider.insertKomoditi(body: body);

  Future<GetListKomoditiData> fetchListKomoditi({Map<String, dynamic> body}) =>
      apiProvider.ApifetchListKomoditi(body: body);

  Future<StandartModels> fetchDelGapoktan({Map<String, dynamic> body}) =>
      apiProvider.actDelGapoktan(body: body);
  // Future<GetMapsPartModels> getListBarangDetail({Map<String, dynamic> body}) =>
  //     apiProvider.getListMaps(body: body);
}
