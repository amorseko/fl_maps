import 'package:fl_maps/src/model/model_master_gapoktan.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListMasterGapoktanBloc {
  final _repository = Repository();
  final _GetListMasterGapoktanData = PublishSubject<GetListMasterGapoktanData>();


  Stream<GetListMasterGapoktanData> get getListKomoditiBloc => _GetListMasterGapoktanData.stream;
  getListMasterGapoktanBloc(Map<String, dynamic> body,Function callback) async {
    GetListMasterGapoktanData model = await _repository.fetchMasterGapoktanApi(body: body);
    _GetListMasterGapoktanData.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _GetListMasterGapoktanData.close();
  }

}