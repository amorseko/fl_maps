import 'package:fl_maps/src/model/model_jenis_proses.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetJenisProsesBloc {
  final _repository = Repository();
  final _getJenisProsesBloc =  PublishSubject<GetListJenisProses>();

  getListJenisProsesBlocs(Map<String, dynamic> body, Function callback) async {
    GetListJenisProses model =
    await _repository.fetchGetListJenisProses(body: body);
//    callback(model.status, model.message);
    _getJenisProsesBloc.sink.add(model);
    callback(model);
  }

  dispose() {
    _getJenisProsesBloc.close();
  }
}