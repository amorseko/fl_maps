import 'package:fl_maps/src/model/model_edit_kinerja.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListKinerjaBloc {
  final _repository = Repository();
  final _GetModelEditKinerja = PublishSubject<GetModelEditKinerja>();


  Stream<GetModelEditKinerja> get getListKinerjaBloc => _GetModelEditKinerja.stream;
  getListKinerja(Map<String, dynamic> body,Function callback) async {
    GetModelEditKinerja model = await _repository.getListKinerja(body: body);
    _GetModelEditKinerja.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _GetModelEditKinerja.close();
  }

}