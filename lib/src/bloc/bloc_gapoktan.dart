import 'package:fl_maps/src/model/model_gapoktan.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListGapoktanBloc {
  final _repository = Repository();
  final _getGapoktanBloc = PublishSubject<GetModelGapoktan>();


  Stream<GetModelGapoktan> get getMapsModels => _getGapoktanBloc.stream;
  getListGapoktanBloc(Map<String, dynamic> body,Function callback) async {
    GetModelGapoktan model = await _repository.getListGapoktan(body: body);
    _getGapoktanBloc.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _getGapoktanBloc.close();
  }

}

final blocGapoktan = ListGapoktanBloc();
