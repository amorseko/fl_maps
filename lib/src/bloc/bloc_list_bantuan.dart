import 'package:fl_maps/src/model/model_list_bantuan.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListBantuanBloc {
  final _repository = Repository();
  final _GetListBantuanModel = PublishSubject<GetListBantuanModel>();


  Stream<GetListBantuanModel> get getListBantuanBloc => _GetListBantuanModel.stream;
  getListBantuanBlocs(Map<String, dynamic> body,Function callback) async {
    GetListBantuanModel model = await _repository.getListBantuan(body: body);
    _GetListBantuanModel.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _GetListBantuanModel.close();
  }

}