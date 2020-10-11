import 'package:fl_maps/src/model/standart_model.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class delBarangDetailBloc{
  final _repository = Repository();
  final _doDelGapoktanBloc = PublishSubject<StandartModels>();

  actDelGapoktanBloc(Map<String, dynamic> body, Function callback) async {
    StandartModels model = await _repository.fetchDelGapoktan(body: body);
    callback(model.status, model.message);
  }

  dispose() {
    _doDelGapoktanBloc.close();
  }
}

final bloc = delBarangDetailBloc();