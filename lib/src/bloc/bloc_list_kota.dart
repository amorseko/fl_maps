import 'package:fl_maps/src/model/model_list_kota.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';


class GetListKotaBloc{
  final _repository = Repository();
  final _getListKota = PublishSubject<GetListKotaModels>();

  getListNamaParangBlocs(Map<String, dynamic> body, Function callback) async {
    GetListKotaModels model = await _repository.fetchDataListKota(body: body);
//    callback(model.status, model.message);
    _getListKota.sink.add(model);
    callback(model);
  }

  dispose() {
    _getListKota.close();
  }
}

final bloc = GetListKotaBloc();