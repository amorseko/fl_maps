import 'package:fl_maps/src/model/model_jenis_bantuan_flag.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class JenisBantuanFlagBloc {
  final _repository = Repository();
  final _JenisBantuanFlagBloc = PublishSubject<GetListJenisBantuanFlagModel>();

  Stream<GetListJenisBantuanFlagModel> get getListJenisBantuanblocs => _JenisBantuanFlagBloc.stream;
  JenisBantuanFlagBlocs(Map<String, dynamic> body,Function(GetListJenisBantuanFlagModel model) callback) async {
    GetListJenisBantuanFlagModel model = await _repository.fetchListJenisBantuanFlag(body: body);
    _JenisBantuanFlagBloc.sink.add(model);
    callback(model);
  }

  dispose() {
    _JenisBantuanFlagBloc.close();
  }
}