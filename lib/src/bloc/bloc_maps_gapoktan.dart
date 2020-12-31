import 'package:fl_maps/src/model/model_maps.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListMapsGapoktanBloc {
  final _repository = Repository();
  final _getMapsGapoktanModels = PublishSubject<GetMapsPartModels>();


  Stream<GetMapsPartModels> get getMapsModels => _getMapsGapoktanModels.stream;


  getListMapsGapoktanBloc(Map<String, dynamic> body,Function callback) async {
    GetMapsPartModels model = await _repository.getListMapGapoktansDetail(body: body);
    _getMapsGapoktanModels.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _getMapsGapoktanModels.close();
  }

}

final bloc = ListMapsGapoktanBloc();
