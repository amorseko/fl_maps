import 'package:fl_maps/src/model/model_jenis_bantuan.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class JenisBantuanBloc {
  final _repository = Repository();
  final _JenisBantuanBloc = PublishSubject<GetListJenisBantuanModel>();

  Stream<GetListJenisBantuanModel> get getListJenisBantuanblocs => _JenisBantuanBloc.stream;
  JenisBantuanBlocs(Function(GetListJenisBantuanModel model) callback) async {
    GetListJenisBantuanModel model = await _repository.fetchListJenisBantuan();
    _JenisBantuanBloc.sink.add(model);
    callback(model);
  }

  dispose() {
    _JenisBantuanBloc.close();
  }
}