import 'package:fl_maps/src/model/model_get_bantuan.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListGetBantuanBloc {
  final _repository = Repository();
  final _GetModelBantuan = PublishSubject<GetModelBantuan>();


  Stream<GetModelBantuan> get getListBantuanBlocs => _GetModelBantuan.stream;
  getListBantuanBloc(Map<String, dynamic> body,Function callback) async {
    GetModelBantuan model = await _repository.fetchGetDataBantuan(body: body);
    _GetModelBantuan.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _GetModelBantuan.close();
  }

}