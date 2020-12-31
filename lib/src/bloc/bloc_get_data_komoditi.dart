import 'package:dio/dio.dart';
import 'package:fl_maps/src/model/model_get_komoditi.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class DataGapoktanBloc {
  final _repository = Repository();
  final _DataGapoktanBloc = PublishSubject<GetModelGetKomoditi>();


  Stream<GetModelGetKomoditi> get getAbsenToday => _DataGapoktanBloc.stream;


  doGetDataKomoditi(Map<String, dynamic> body, Function callback) async {
    GetModelGetKomoditi model = await _repository.getKomoditiData(body: body);
    _DataGapoktanBloc.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _DataGapoktanBloc.close();
  }


}
