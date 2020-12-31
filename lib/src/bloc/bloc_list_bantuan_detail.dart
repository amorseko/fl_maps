import 'package:fl_maps/src/model/model_bantuan_detail.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListBantuanDetailBloc {
  final _repository = Repository();
  final _GetModelBantuanDetail = PublishSubject<GetModelBantuanDetail>();


  Stream<GetModelBantuanDetail> get getListBantuanDetailBloc =>
      _GetModelBantuanDetail.stream;

  getListBantuanDetailBlocs(Map<String, dynamic> body, Function callback) async {
    GetModelBantuanDetail model = await _repository.getListBantuanDetail(body: body);
    _GetModelBantuanDetail.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _GetModelBantuanDetail.close();
  }
}