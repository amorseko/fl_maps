import 'package:fl_maps/src/model/model_bantuan_new.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListBantuanNewBloc {
  final _repository = Repository();
  final _GetModelBantuanNew = PublishSubject<GetModelBantuanNew>();


  Stream<GetModelBantuanNew> get getListBantuanBloc =>
      _GetModelBantuanNew.stream;

  getListBantuanBlocs(Map<String, dynamic> body, Function callback) async {
    GetModelBantuanNew model = await _repository.getListBantuanNew(body: body);
    _GetModelBantuanNew.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _GetModelBantuanNew.close();
  }
}