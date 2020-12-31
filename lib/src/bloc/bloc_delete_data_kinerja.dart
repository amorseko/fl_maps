import 'package:fl_maps/src/model/standart_model.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class delDataBantuanBloc{
  final _repository = Repository();
  final _doDelBantuanBloc = PublishSubject<StandartModels>();

  actDelDataBantuanBloc(Map<String, dynamic> body, Function callback) async {
    StandartModels model = await _repository.fetchDelDataKinerja(body: body);
    callback(model.status, model.message);
  }

  dispose() {
    _doDelBantuanBloc.close();
  }
}

final bloc = delDataBantuanBloc();