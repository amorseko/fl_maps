import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fl_maps/src/model/aboutus_model.dart';
import 'package:fl_maps/src/model/default_model.dart';
import 'package:fl_maps/src/model/model_bantuan_detail.dart';
import 'package:fl_maps/src/model/model_bantuan_new.dart';
import 'package:fl_maps/src/model/model_data_kinerja.dart';
import 'package:fl_maps/src/model/model_edit_kinerja.dart';
import 'package:fl_maps/src/model/model_get_bantuan.dart';
import 'package:fl_maps/src/model/model_get_inven_gapoktan.dart';
import 'package:fl_maps/src/model/model_jenis_bantuan_flag.dart';
import 'package:fl_maps/src/model/model_jenis_proses.dart';
import 'package:fl_maps/src/model/model_list_kota.dart';
import 'package:fl_maps/src/model/model_list_notif.dart';
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
import 'package:fl_maps/src/model/member_model.dart';

class ApiProvider {
  Dio _dio;
  Dio _dioSecond;

  // String _baseUrl = 'http://103.56.149.42/asiap/mobile_api/';
//  String _baseUrl = 'http://52.221.209.34/';
    String _baseUrl = 'https://assiapbun.id/api_fl_maps/';

//  String _baseUrl = 'http://192.168.241.96/api_flmaps/';
  ApiProvider() {
    // SharedPreferencesHelper.getToken().then((token) {
    BaseOptions options = BaseOptions(
        receiveTimeout: 5000,
        baseUrl: _baseUrl,
        connectTimeout: 5000,
        responseType: ResponseType.json,
        contentType: Headers.formUrlEncodedContentType);

    BaseOptions optionsSecond = BaseOptions(
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
        receiveTimeout: 1000000,
        responseType: ResponseType.json,
        connectTimeout: 1000000,
        contentType: Headers.formUrlEncodedContentType);

    _dio = Dio(options);
    _dioSecond = Dio(optionsSecond);
    _setupLoggingInterceptor();
    //});
  }
  Future<Dio> _syncConnWithoutToken() async {
    Dio _dio;
    BaseOptions options = BaseOptions(
        receiveTimeout: 5000,
        connectTimeout: 5000,
        baseUrl: _baseUrl,
        contentType: Headers.formUrlEncodedContentType);
    _dio = Dio(options);
    return _dio;
  }

  Future<Dio> _syncFormData() async {
    Dio _dioSecond;
    BaseOptions optionsSecond = BaseOptions(
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
        receiveTimeout: 1000000,
        connectTimeout: 1000000,
        contentType: Headers.formUrlEncodedContentType);
    _dioSecond = Dio(optionsSecond);
    return _dio;
  }

  String _handleError(error) {
    print(error);
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              "Received invalid status code: ${error.response.statusCode}";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured " + error.toString();
    }
    return errorDescription;
  }

  void _setupLoggingInterceptor() {
    int maxCharactersPerLine = 200;

    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      //SharedPreferencesHelper.getToken().then((token) {
      print("--> ${options.method} ${options.path}");
      print("Header: ${options.headers}");
      print("Content type: ${options.contentType}");
      print("Body: ${options.data}");
      print("<-- END HTTP");
      //});
      return options;
    }, onResponse: (Response response) {
      print(
          "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
      String responseAsString = response.data.toString();
      if (responseAsString.length > maxCharactersPerLine) {
        int iterations =
            (responseAsString.length / maxCharactersPerLine).floor();
        for (int i = 0; i <= iterations; i++) {
          int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
          if (endingIndex > responseAsString.length) {
            endingIndex = responseAsString.length;
          }
          print(responseAsString.substring(
              i * maxCharactersPerLine, endingIndex));
        }
      } else {
        print(response.data);
      }
      print("<-- END HTTP");
    }, onError: (DioError error) {
      print(error);
    }));
  }

  Future<GetMapsPartModels> fetchListMaps({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
        "show_maps.php", data: json.encode(body)
      );
      print(response.data);
      return GetMapsPartModels.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<GetModelGapoktan> fetchListGapoktan({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();
    print(body);
    try {
      final response = await _dio.post(
        "show_gapoktan.php", data: json.encode(body)
      );
      print(response.data);
      return GetModelGapoktan.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<MemberModels> login({Map<String, dynamic> body}) async {
//    final _dio = await _syncConn();
    final _dio = await _syncConnWithoutToken();
    try {
      final response = await _dio.post("/dologin.php", data: json.encode(body));
      print(response.data.toString());
      return MemberModels.fromJson(response.data);
    } catch (error, _) {
      return MemberModels.withError(_handleError(error));
    }
  }

  Future<DefaultModel> submitBantuan({FormData formData}) async {
    final _dioSecond = await _syncConnWithoutToken();
    try {
//      final response = await _dioSecond.post(_baseUrl+"save_absen.php", data: formData, onSendProgress:  (int sent, int total) {
//        print("progress >>> " +
//            ((sent / total) * 100).floor().toString() +
//            "%");
//      });

      print(formData);
      final response =
          await _dioSecond.post(_baseUrl + "save_bantuan.php", data: formData);
      print("response absen : $response");
      print(response.data.toString());
      return DefaultModel.fromJson(response.data);
    } catch (error, _) {
      print("error kesini :");
      print(_handleError(error));
    }
  }

  Future<GetListModelProvinsi> fetchListProvinsi() async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response = await _dio.post("/provinsi.php");
      print(response.data);
      return GetListModelProvinsi.fromJson(response.data);
    } catch (error, stack) {
      print(stack.toString());
      return GetListModelProvinsi.withError(_handleError(error));
    }
  }

  Future<GetListModelMasterKomoditi> fetchGetMasterKomoditiApi() async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response = await _dio.post("/master_komoditi.php");
      print(response.data);
      return GetListModelMasterKomoditi.fromJson(response.data);
    } catch (error, stack) {
      print(stack.toString());
      return GetListModelMasterKomoditi.withError(_handleError(error));
    }
  }

  Future<StandartModels> insertGapoktan({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response =
      await _dio.post("/insert_gapoktan.php", data: json.encode(body));
      print(response.data);
      return StandartModels.fromJson(response.data);
    } catch (error, _) {
      return StandartModels.withError(_handleError(error));
    }
  }

  Future<GetListJenisBantuanModel> fetchListJenisBantuanApi({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
          "jenis_bantuan.php", data: json.encode(body)
      );
      print(response.data);
      return GetListJenisBantuanModel.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<StandartModels> insertKomoditi({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response =
      await _dio.post("/insert_komoditi.php", data: json.encode(body));
      print(response.data);
      return StandartModels.fromJson(response.data);
    } catch (error, _) {
      return StandartModels.withError(_handleError(error));
    }
  }

  Future<GetListKomoditiData> ApifetchListKomoditi({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
        "master_komoditi.php",
      );
      print(response.data);
      return GetListKomoditiData.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<StandartModels> actDelGapoktan({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response =
      await _dio.post("/delete_gapoktan.php", data: json.encode(body));
      print(response.data);
      return StandartModels.fromJson(response.data);
    } catch (error, _) {
      return StandartModels.withError(_handleError(error));
    }
  }

  Future<GetModelEditGapoktan> apiGetGapoktanData({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response =
      await _dio.post("/select_gapoktan.php", data: json.encode(body));
      return GetModelEditGapoktan.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<StandartModels> actDelKomoditi({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response =
      await _dio.post("/delete_komoditi.php", data: json.encode(body));
      print(response.data);
      return StandartModels.fromJson(response.data);
    } catch (error, _) {
      return StandartModels.withError(_handleError(error));
    }
  }

  Future<GetModelGetKomoditi> apiGetDataKomoditi({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response =
      await _dio.post("/select_komoditi.php", data: json.encode(body));
      print(response.data);
      return GetModelGetKomoditi.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<GetListBantuanModel> fetchListBantuan({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
        "show_bantuan.php",
      );
      print(response.data);
      return GetListBantuanModel.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<GetModelBantuan> ApifetchGetDataBantuan({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
        "selected_bantuan.php", data: json.encode(body));
      print(response.data);
      return GetModelBantuan.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<StandartModels> actDelBantuan({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response =
      await _dio.post("/delete_bantuan.php", data: json.encode(body));
      print(response.data);
      return StandartModels.fromJson(response.data);
    } catch (error, _) {
      return StandartModels.withError(_handleError(error));
    }
  }

  Future<GetListKotaModels> fetchListKota(
      {Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response =
      await _dio.post("/list_kota.php", data: json.encode(body));
      print(response.data);
      return GetListKotaModels.fromJson(response.data);
    } catch (error, _) {
      return GetListKotaModels.withError(_handleError(error));
    }
  }

  Future<GetListJenisProses> apiListJenisProses(
      {Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response =
      await _dio.post("/jenis_proses.php", data: json.encode(body));
      print(response.data);
      return GetListJenisProses.fromJson(response.data);
    } catch (error, _) {
      return GetListJenisProses.withError(_handleError(error));
    }
  }

  Future<GetModelEditKinerja> apiListDataKinerja({Map<String, dynamic> body}) async {

    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
        "selected_kinerja.php", data: json.encode(body)
      );
//      print("data kinerja : " + response.data);
      return GetModelEditKinerja.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }

  }

  Future<StandartModels> actDelKinerja({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response =
      await _dio.post("/delete_kinerja.php", data: json.encode(body));
      print(response.data);
      return StandartModels.fromJson(response.data);
    } catch (error, _) {
      return StandartModels.withError(_handleError(error));
    }
  }

  Future<DefaultModel> apiSubmitJenisProses({FormData formData}) async {
    final _dioSecond = await _syncConnWithoutToken();
    try {


      print(formData);
      final response =
      await _dioSecond.post(_baseUrl + "save_kinerja.php", data: formData);
      print("response data : $response");
      print(response.data.toString());
      return DefaultModel.fromJson(response.data);
    } catch (error, _) {
      print("error kesini :");
      print(_handleError(error));
    }
  }

  // Future<GetListModelTotalData> fetchListTotalData({Map<String, dynamic> body}) async {
  Future<GetListModelTotalData> fetchListTotalData() async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response = await _dio.post("total_data.php");
      print(response.data);
      return GetListModelTotalData.fromJson(response.data);
    } catch (error, stack) {
      print(stack.toString());
      return GetListModelTotalData.withError(_handleError(error));
    }
  }

  Future<DefaultModel> submitInvetoryGapoktan({FormData formData}) async {
    final _dioSecond = await _syncConnWithoutToken();
    try {
//      final response = await _dioSecond.post(_baseUrl+"save_absen.php", data: formData, onSendProgress:  (int sent, int total) {
//        print("progress >>> " +
//            ((sent / total) * 100).floor().toString() +
//            "%");
//      });

      print(formData);
      final response =
      await _dioSecond.post(_baseUrl + "save_inventory_gapoktan.php", data: formData);
      print("response data : $response");
      print(response.data.toString());
      return DefaultModel.fromJson(response.data);
    } catch (error, _) {
      print("error kesini :");
      print(_handleError(error));
    }
  }

  Future<GetModelListInvenGapoktan> fetchListInvenGapoktan({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
        "show_inventory_gapoktan.php",
      );
      print(response.data);
      return GetModelListInvenGapoktan.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<StandartModels> actDelInvenGapoktan({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response =
      await _dio.post("/delete_inventory_gapoktan.php", data: json.encode(body));
      print(response.data);
      return StandartModels.fromJson(response.data);
    } catch (error, _) {
      return StandartModels.withError(_handleError(error));
    }
  }

//  Future<GetModelInvenGapoktan> apiListDataInvenGapoktan({Map<String, dynamic> body}) async {
//
//    final _dio = await _syncConnWithoutToken();
//
//    try {
//      final response = await _dio.post(
//          "selected_inven_gapoktan.php", data: json.encode(body)
//      );
//      print("data nya : " + response.data);
//      return GetModelInvenGapoktan.fromJson(response.data);
//    } catch (error, _) {
////      return _handleError(error);
//    }
//
//  }

  Future<GetModelInvenGapoktan> apiListDataInvenGapoktan({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
          "selected_inven_gapoktan.php", data: json.encode(body));
      print(response.data);
      return GetModelInvenGapoktan.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<GetMapsPartModels> fetchListMapsGapoktan({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
          "show_maps_gapoktan.php", data: json.encode(body)
      );
      print(response.data);
      return GetMapsPartModels.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

//  Future<GetListMasterGapoktanData> fetchMasterGapoktan() async {
//    final _dio = await _syncConnWithoutToken();
//    try {
//      final response = await _dio.post("/master_gapoktan.php");
//      print(response.data);
//      return GetListMasterGapoktanData.fromJson(response.data);
//    } catch (error, stack) {
//      print(stack.toString());
//      return GetListMasterGapoktanData.withError(_handleError(error));
//    }
//  }

  Future<GetListMasterGapoktanData> fetchMasterGapoktan({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
        "master_gapoktan.php",
      );
      print(response.data);
      return GetListMasterGapoktanData.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<GetListJenisBantuanFlagModel> fetchJensiBantuanFlag({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
          "cmb_jenis_bantuan.php", data: json.encode(body)
      );
      print(response.data);
      return GetListJenisBantuanFlagModel.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<DefaultModel> apiSubmitPesan({FormData formData}) async {
    final _dioSecond = await _syncConnWithoutToken();
    try {


      print(formData);
      final response =
      await _dioSecond.post(_baseUrl + "save_pesan.php", data: formData);
      print("response data : $response");
      print(response.data.toString());
      return DefaultModel.fromJson(response.data);
    } catch (error, _) {
      print("error kesini :");
      print(_handleError(error));
    }
  }

  Future<GetModelDataKinerja> apiListDataKinerjaOnly({Map<String, dynamic> body}) async {

    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
          "selected_data_kinerja.php", data: json.encode(body)
      );
//      print("data kinerja : " + response.data);
      return GetModelDataKinerja.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }

  }

  Future<StandartModels> actDelDataKinerja({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response =
      await _dio.post("/delete_data_kinerja.php", data: json.encode(body));
      print(response.data);
      return StandartModels.fromJson(response.data);
    } catch (error, _) {
      return StandartModels.withError(_handleError(error));
    }
  }

  Future<GetListMasterJenisBantuan> fetchMasterJenisBantuan({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
        "master_jenis_bantuan.php",
      );
      print(response.data);
      return GetListMasterJenisBantuan.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<DefaultModel> apiSubmitDataKinerja({FormData formData}) async {
    final _dioSecond = await _syncConnWithoutToken();
    try {


      print(formData);
      final response =
      await _dioSecond.post(_baseUrl + "save_data_kinerja.php", data: formData);
      print("response data : $response");
      print(response.data.toString());
      return DefaultModel.fromJson(response.data);
    } catch (error, _) {
      print("error kesini :");
      print(_handleError(error));
    }
  }

  Future<DefaultModel> apiSubmitPictUser({FormData formData}) async {
    final _dioSecond = await _syncConnWithoutToken();
    try {


      print(formData);
      final response =
      await _dioSecond.post(_baseUrl + "update_pict.php", data: formData);
      print("response data : $response");
      print(response.data.toString());
      return DefaultModel.fromJson(response.data);
    } catch (error, _) {
      print("error kesini :");
      print(_handleError(error));
    }
  }

  Future<StandartModels> changePass({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response =
      await _dio.post("/change_pass.php", data: json.encode(body));
      return StandartModels.fromJson(response.data);
    } catch (error, _) {
      return StandartModels.withError(_handleError(error));
    }
  }

  Future<StandartModels> changeProfile({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response =
      await _dio.post("/change_profile.php", data: json.encode(body));
      print(response.data);
      return StandartModels.fromJson(response.data);
    } catch (error, _) {
      return StandartModels.withError(_handleError(error));
    }
  }

  Future<AboutsModels> fetchaboutApi() async {
    try {
      final response = await _dio.post("/list_about_us.php");
      return AboutsModels.fromJson(response.data);
    } catch (error, stack) {
      print(stack.toString());
      return AboutsModels.withError(_handleError(error));
    }
  }

  Future<GetModelBantuanNew> fetchListBantuanNew({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
        "show_bantuan_new.php", data: json.encode(body)
      );
      print(response.data);
      return GetModelBantuanNew.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<GetModelBantuanDetail> fetchListBantuanDetail({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
        "show_bantuan_detail.php",data: json.encode(body)
      );
      print(response.data);
      return GetModelBantuanDetail.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<GetMapsGapoktanModels> fetchListMapsNewGapoktan({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
          "show_maps_gapoktan_new.php", data: json.encode(body)
      );
      print(response.data);
      return GetMapsGapoktanModels.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }

  Future<GetMapsKomoditiModels> fetchListMapsKomoditi({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();

    try {
      final response = await _dio.post(
          "show_maps_komoditi.php", data: json.encode(body)
      );
      print(response.data);
      return GetMapsKomoditiModels.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
    }
  }
  Future<StandartModels> actUpdateToken({Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response =
      await _dio.post("/update_token.php", data: json.encode(body));
      return StandartModels.fromJson(response.data);
    } catch (error, _) {
      return StandartModels.withError(_handleError(error));
    }
  }

  Future<GetListNotifModels> fetchListNotif(
      {Map<String, dynamic> body}) async {
    final _dio = await _syncConnWithoutToken();
    try {
      final response =
      await _dio.post("/list_notif.php", data: json.encode(body));
      print(response.data);
      return GetListNotifModels.fromJson(response.data);
    } catch (error, _) {
      //return GetListNotifModels.withError(_handleError(error));
    }
  }
}