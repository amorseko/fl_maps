import 'package:fl_maps/src/model/standart_model.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class delKomoditiBloc{
  final _repository = Repository();
  final _doDelKomoditiBloc = PublishSubject<StandartModels>();

  actDelKomoditiBloc(Map<String, dynamic> body, Function callback) async {
    StandartModels model = await _repository.fetchDelKomoditi(body: body);
    callback(model.status, model.message);
  }

  dispose() {
    _doDelKomoditiBloc.close();
  }
}

final bloc = delKomoditiBloc();