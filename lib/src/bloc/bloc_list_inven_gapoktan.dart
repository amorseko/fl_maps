import 'package:fl_maps/src/model/model_get_inven_gapoktan.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListGetInvenGapoktanBloc {
  final _repository = Repository();
  final _GetModelInvenGapoktan = PublishSubject<GetModelInvenGapoktan>();


  Stream<GetModelInvenGapoktan> get getListBantuanBlocs => _GetModelInvenGapoktan.stream;
  getInvenGapoktanBloc(Map<String, dynamic> body,Function callback) async {
    GetModelInvenGapoktan model = await _repository.getListDataInvenGapoktan(body: body);

    _GetModelInvenGapoktan.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _GetModelInvenGapoktan.close();
  }

}