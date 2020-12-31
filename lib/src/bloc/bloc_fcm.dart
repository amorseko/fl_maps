import 'package:fl_maps/src/model/standart_model.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class updateTokenFcmBloc{
  final _repository = Repository();
  final _doUpdateToken = PublishSubject<StandartModels>();

  actUpdateToken(Map<String, dynamic> body, Function callback) async {
    StandartModels model = await _repository.fetchUpdateToken(body: body);
    callback(model.status, model.message);
  }

  dispose() {
    _doUpdateToken.close();
  }
}

final bloc = updateTokenFcmBloc();