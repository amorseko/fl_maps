import 'package:fl_maps/src/model/model_list_notif.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';


class GetListNotifBloc{
  final _repository = Repository();
  final _getListNotif = PublishSubject<GetListNotifModels>();

  Stream<GetListNotifModels> get getListNotif =>
      _getListNotif.stream;

  GetListNotif(Map<String, dynamic> body, Function callback) async {
    GetListNotifModels model = await _repository.fetchDataNotif(body: body);
    _getListNotif.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }


  dispose() {
    _getListNotif.close();
  }
}
