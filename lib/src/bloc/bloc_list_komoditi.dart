import 'package:fl_maps/src/model/model_list_komoditi.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListKomoditiBloc {
  final _repository = Repository();
  final _GetListKomoditiData = PublishSubject<GetListKomoditiData>();


  Stream<GetListKomoditiData> get getListKomoditiBloc => _GetListKomoditiData.stream;
  getListKomoditiBlocs(Map<String, dynamic> body,Function callback) async {
    GetListKomoditiData model = await _repository.fetchListKomoditi(body: body);
    _GetListKomoditiData.sink.add(model);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _GetListKomoditiData.close();
  }

}