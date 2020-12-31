import 'package:fl_maps/src/model/model_total_data.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetListTotalDataBloc {
  final _repository = Repository();
  final _GetListTotalDataBloc = PublishSubject<GetListModelTotalData>();

  Stream<GetListModelTotalData> get getListProvince => _GetListTotalDataBloc.stream;

  getListTotalData(Map<String, dynamic> body,Function callback) async {
    GetListModelTotalData model = await _repository.fetchGetListTotalData();
    _GetListTotalDataBloc.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

//  getListTotalData(Function(GetListModelTotalData model) callback) async {
//    GetListModelTotalData model = await _repository.fetchGetListTotalData();
//    _GetListTotalDataBloc.sink.add(model);
//    callback(model);
//  }

  dispose() {
    _GetListTotalDataBloc.close();
  }
}


final bloc = GetListTotalDataBloc();