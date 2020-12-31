import 'package:dio/dio.dart';
import 'package:fl_maps/src/model/model_edit_gapoktan.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class _GapoktanDataBloc {
  final _repository = Repository();
  final _getDataEditGapoktan = PublishSubject<GetModelEditGapoktan>();


  Stream<GetModelEditGapoktan> get getAbsenToday => _getDataEditGapoktan.stream;


  doGetDataGapoktan(Map<String, dynamic> body, Function callback) async {
    GetModelEditGapoktan model = await _repository.getGapoktanData(body: body);
    _getDataEditGapoktan.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _getDataEditGapoktan.close();
  }


}

final bloc = _GapoktanDataBloc();