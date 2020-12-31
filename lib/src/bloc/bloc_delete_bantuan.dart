import 'package:fl_maps/src/model/standart_model.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class delBantuanBloc{
  final _repository = Repository();
  final _doDelBantuanBloc = PublishSubject<StandartModels>();

  actDelBantuanBloc(Map<String, dynamic> body, Function callback) async {
    StandartModels model = await _repository.fetchDelBantuan(body: body);
    callback(model.status, model.message);
  }

  dispose() {
    _doDelBantuanBloc.close();
  }
}

final bloc = delBantuanBloc();