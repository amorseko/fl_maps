import 'package:dio/dio.dart';
import 'package:fl_maps/src/model/aboutus_model.dart';
import 'package:fl_maps/src/model/default_model.dart';
import 'package:fl_maps/src/model/model_bantuan_detail.dart';
import 'package:fl_maps/src/model/model_bantuan_new.dart';
import 'package:fl_maps/src/model/model_data_kinerja.dart';
import 'package:fl_maps/src/model/model_edit_kinerja.dart';
import 'package:fl_maps/src/model/model_get_inven_gapoktan.dart';
import 'package:fl_maps/src/model/model_jenis_bantuan_flag.dart';
import 'package:fl_maps/src/model/model_jenis_proses.dart';
import 'package:fl_maps/src/model/model_maps.dart';
import 'package:fl_maps/src/model/model_gapoktan.dart';
import 'package:fl_maps/src/model/model_maps_gapoktan_new.dart';
import 'package:fl_maps/src/model/model_maps_komoditi.dart';
import 'package:fl_maps/src/model/model_master_gapoktan.dart';
import 'package:fl_maps/src/model/model_master_jenis_bantuan.dart';
import 'package:fl_maps/src/model/model_provinsi.dart';
import 'package:fl_maps/src/model/model_master_komoditi.dart';
import 'package:fl_maps/src/model/model_show_invengapoktan.dart';
import 'package:fl_maps/src/model/model_total_data.dart';
import 'package:fl_maps/src/model/standart_model.dart';
import 'package:fl_maps/src/model/model_jenis_bantuan.dart';
import 'package:fl_maps/src/model/model_list_komoditi.dart';
import 'package:fl_maps/src/model/model_edit_gapoktan.dart';
import 'package:fl_maps/src/model/model_get_komoditi.dart';
import 'package:fl_maps/src/model/model_list_bantuan.dart';
import 'package:fl_maps/src/model/model_get_bantuan.dart';
import 'package:fl_maps/src/model/model_list_kota.dart';

import 'package:fl_maps/src/resources/api_provider.dart';
import 'package:fl_maps/src/model/member_model.dart';

class Repository {
  final apiProvider = ApiProvider();
  Future<MemberModels> actLogin({Map<String, dynamic> body}) =>
      apiProvider.login(body: body);

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

  Future<GetModelEditGapoktan> getGapoktanData({Map<String, dynamic> body}) =>
      apiProvider.apiGetGapoktanData(body: body);

  Future<StandartModels> fetchDelKomoditi({Map<String, dynamic> body}) =>
      apiProvider.actDelKomoditi(body: body);

  Future<GetModelGetKomoditi> getKomoditiData({Map<String, dynamic> body}) =>
      apiProvider.apiGetDataKomoditi(body: body);

  Future<GetListBantuanModel> getListBantuan({Map<String, dynamic> body}) =>
      apiProvider.fetchListBantuan(body: body);

  Future<GetModelBantuan> fetchGetDataBantuan({Map<String, dynamic> body}) =>
      apiProvider.ApifetchGetDataBantuan(body: body);

  Future<StandartModels> fetchDelBantuan({Map<String, dynamic> body}) =>
      apiProvider.actDelBantuan(body: body);

  Future<GetListKotaModels> fetchDataListKota({Map<String, dynamic> body}) =>
      apiProvider.fetchListKota(body: body);

  Future<GetListJenisProses> fetchGetListJenisProses(
      {Map<String, dynamic> body}) =>
      apiProvider.apiListJenisProses(body: body);

  Future<GetModelEditKinerja> getListKinerja({Map<String, dynamic> body}) =>
      apiProvider.apiListDataKinerja(body: body);

  Future<StandartModels> fetchDelKinerja({Map<String, dynamic> body}) =>
      apiProvider.actDelKinerja(body: body);

  Future<DefaultModel> submitJenisProses({FormData formData}) =>
      apiProvider.apiSubmitJenisProses(formData: formData);

  Future<GetListModelTotalData> fetchGetListTotalData() =>
      apiProvider.fetchListTotalData();

  Future<DefaultModel> submitInvetoryGapoktan({FormData formData}) =>
      apiProvider.submitInvetoryGapoktan(formData: formData);

  Future<GetModelListInvenGapoktan> getListInvenGapoktan({Map<String, dynamic> body}) =>
      apiProvider.fetchListInvenGapoktan(body: body);

  Future<StandartModels> fetchDelInvenGapoktan({Map<String, dynamic> body}) =>
      apiProvider.actDelBantuan(body: body);

  Future<GetModelInvenGapoktan> getListDataInvenGapoktan({Map<String, dynamic> body}) =>
      apiProvider.apiListDataInvenGapoktan(body: body);

  Future<GetMapsPartModels> getListMapGapoktansDetail({Map<String, dynamic> body}) =>
      apiProvider.fetchListMapsGapoktan(body: body);

  Future<GetListMasterGapoktanData> fetchMasterGapoktanApi({Map<String, dynamic> body}) =>
      apiProvider.fetchMasterGapoktan(body: body);

  Future<GetListJenisBantuanFlagModel> fetchListJenisBantuanFlag({Map<String, dynamic> body}) =>
      apiProvider.fetchJensiBantuanFlag(body: body);

  Future<DefaultModel> submitPesan({FormData formData}) =>
      apiProvider.apiSubmitPesan(formData: formData);

  Future<GetModelDataKinerja> getListDataKinerja({Map<String, dynamic> body}) =>
      apiProvider.apiListDataKinerjaOnly(body: body);

  Future<StandartModels> fetchDelDataKinerja({Map<String, dynamic> body}) =>
      apiProvider.actDelDataKinerja(body: body);

  Future<GetListMasterJenisBantuan> fetchMasterJenisBantuan({Map<String, dynamic> body}) =>
      apiProvider.fetchMasterJenisBantuan(body: body);

  Future<DefaultModel> submitDataKinerja({FormData formData}) =>
      apiProvider.apiSubmitDataKinerja(formData: formData);

  Future<DefaultModel> submitUpdatePict({FormData formData}) =>
      apiProvider.apiSubmitPictUser(formData: formData);

  Future<StandartModels> actChangePassUser({Map<String, dynamic> body}) =>
      apiProvider.changePass(body: body);

  Future<StandartModels> actChangeProfileUser({Map<String, dynamic> body}) =>
      apiProvider.changeProfile(body: body);

  Future<AboutsModels> fetchAbout() => apiProvider.fetchaboutApi();

  Future<GetModelBantuanNew> getListBantuanNew({Map<String, dynamic> body}) =>
      apiProvider.fetchListBantuanNew(body: body);

  Future<GetModelBantuanDetail> getListBantuanDetail({Map<String, dynamic> body}) =>
      apiProvider.fetchListBantuanDetail(body: body);

  Future<GetMapsGapoktanModels> getListMapGapoktansNew({Map<String, dynamic> body}) =>
      apiProvider.fetchListMapsNewGapoktan(body: body);

  Future<GetMapsKomoditiModels> getListMapKomoditi({Map<String, dynamic> body}) =>
      apiProvider.fetchListMapsKomoditi(body: body);

  Future<StandartModels> fetchUpdateToken({Map<String, dynamic> body}) =>
      apiProvider.actUpdateToken(body: body);
}
