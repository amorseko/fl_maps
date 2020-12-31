import 'package:fl_maps/src/model/model_show_invengapoktan.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListInvenGapoktanBloc {
  final _repository = Repository();
  final _GetListInvenGapoktanBloc = PublishSubject<GetModelListInvenGapoktan>();


  Stream<GetModelListInvenGapoktan> get getListBantuanBloc => _GetListInvenGapoktanBloc.stream;
  GetListInvenGapoktanBloc(Map<String, dynamic> body,Function callback) async {
    GetModelListInvenGapoktan model = await _repository.getListInvenGapoktan(body: body);
    _GetListInvenGapoktanBloc.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _GetListInvenGapoktanBloc.close();
  }

}