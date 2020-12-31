import 'package:fl_maps/src/model/model_data_kinerja.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListDataKinerjaBloc {
  final _repository = Repository();
  final _GetModelEditKinerja = PublishSubject<GetModelDataKinerja>();


  Stream<GetModelDataKinerja> get getListKinerjaBloc => _GetModelEditKinerja.stream;
  getListDataKinerja(Map<String, dynamic> body,Function callback) async {
    GetModelDataKinerja model = await _repository.getListDataKinerja(body: body);
    _GetModelEditKinerja.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _GetModelEditKinerja.close();
  }

}