//import 'package:fl_maps/src/model/model_master_jenis_bantuan.dart';
//import 'package:fl_maps/src/resources/repository.dart';
//import 'package:rxdart/rxdart.dart';
//
//class ListMasterJenisBantuanBloc {
//  final _repository = Repository();
//  final _GetListMasterJenisBantuan = PublishSubject<GetListMasterJenisBantuan>();
//
//
//  Stream<GetListMasterJenisBantuan> get getListKomoditiBloc => _GetListMasterJenisBantuan.stream;
//  getListMasterJenisBantuan(Map<String, dynamic> body,Function callback) async {
//    GetListMasterJenisBantuan model = await _repository.fetchMasterJenisBantuan(body: body);
//    _GetListMasterJenisBantuan.sink.add(model);
//    callback(model.status, model.error, model.message, model);
//  }
//
//  dispose() {
//    _GetListMasterJenisBantuan.close();
//  }
//
//}

import 'package:fl_maps/src/model/model_master_jenis_bantuan.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListMasterJenisBantuanBloc {
  final _repository = Repository();
  final _GetListMasterJenisBantuan = PublishSubject<GetListMasterJenisBantuan>();

  Stream<GetListMasterJenisBantuan> get getListMasterJenisBantuanBlocs => _GetListMasterJenisBantuan.stream;
  getListMasterJenisBantuan(Function(GetListMasterJenisBantuan model) callback) async {
    GetListMasterJenisBantuan model = await _repository.fetchMasterJenisBantuan();
    _GetListMasterJenisBantuan.sink.add(model);
    callback(model);
  }

  dispose() {
    _GetListMasterJenisBantuan.close();
  }
}