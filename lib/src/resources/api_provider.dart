import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fl_maps/src/model/default_model.dart';
import 'package:fl_maps/src/model/model_maps.dart';
import 'package:fl_maps/src/model/model_gapoktan.dart';
import 'package:fl_maps/src/model/model_provinsi.dart';
import 'package:fl_maps/src/model/model_master_komoditi.dart';
import 'package:fl_maps/src/model/standart_model.dart';
import 'package:fl_maps/src/model/model_jenis_bantuan.dart';
import 'package:fl_maps/src/model/model_list_komoditi.dart';

class ApiProvider {
  Dio _dio;
  Dio _dioSecond;

  // String _baseUrl = 'http://103.56.149.42/asiap/mobile_api/';
  String _baseUrl = 'http://52.221.209.34/';

  ApiProvider() {
    // SharedPreferencesHelper.getToken().then((token) {
    BaseOptions options = BaseOptions(
        receiveTimeout: 5000,
        baseUrl: _baseUrl,
        connectTimeout: 5000,
        contentType: Headers.formUrlEncodedContentType);

    BaseOptions optionsSecond = BaseOptions(
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
        receiveTimeout: 1000000,
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

    try {
      final response = await _dio.post(
        "show_gapoktan.php",
      );
      print(response.data);
      return GetModelGapoktan.fromJson(response.data);
    } catch (error, _) {
//      return _handleError(error);
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
}
