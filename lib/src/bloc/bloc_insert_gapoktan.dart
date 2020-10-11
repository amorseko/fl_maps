import 'package:fl_maps/src/model/standart_model.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class InsertGapoktanBloc{
  final _repository = Repository();
  final _InsertGapoktanBloc = PublishSubject<StandartModels>();

  actInsertGapoktan(Map<String, dynamic> body, Function callback) async {
    StandartModels model = await _repository.actInsertGapoktan(body: body);
    callback(model.status, model.message);
  }

  dispose() {
    _InsertGapoktanBloc.close();
  }
}

final bloc = InsertGapoktanBloc();