//import 'package:dio/dio.dart';
//import 'package:fl_maps/src/resources/repository.dart';
//import 'package:fl_maps/src/model/model_maps.dart';
//import 'package:rxdart/rxdart.dart';
//
//class ListMapsBloc {
//  final _repository = Repository();
//  final _getListMaps = PublishSubject<GetMapsPartModels>();
//
//  Stream<GetMapsPartModels> get getListMaps => _getListMaps.stream;
//
//
//  getListMapsBloc(Map<String, dynamic> body, Function callback) async {
//    GetMapsPartModels model = await _repository.getListMapsDetail(body: body);
//    _getListMaps.sink.add(model);
//    callback(model.status, model.error, model.message, model);
//  }
//
//  dispose() {
//    _getListMaps.close();
//  }
//}
//
//final bloc = ListMapsBloc();

import 'package:dio/dio.dart';
import 'package:fl_maps/src/model/model_maps_komoditi.dart';
//import 'package:fl_maps/src/model/model_maps_gapoktan_new.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListMapsKomoditiBloc {
  final _repository = Repository();
  final _getMapsModelsKomoditi = PublishSubject<GetMapsKomoditiModels>();


  Stream<GetMapsKomoditiModels> get getMapsModels => _getMapsModelsKomoditi.stream;


  getListMapsKomoditiBloc(Map<String, dynamic> body,Function callback) async {
    GetMapsKomoditiModels model = await _repository.getListMapKomoditi(body: body);
    _getMapsModelsKomoditi.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _getMapsModelsKomoditi.close();
  }

}

final bloc = ListMapsKomoditiBloc();
