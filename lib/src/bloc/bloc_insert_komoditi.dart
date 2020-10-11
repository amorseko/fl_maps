import 'package:fl_maps/src/model/standart_model.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class InsertKomoditiBloc{
  final _repository = Repository();
  final _insertKomoditiBloc = PublishSubject<StandartModels>();

  actInsertKomoditiBloc(Map<String, dynamic> body, Function callback) async {
    StandartModels model = await _repository.actInsertKomoditi(body: body);
    callback(model.status, model.message);
  }

  dispose() {
    _insertKomoditiBloc.close();
  }
}

final bloc = InsertKomoditiBloc();