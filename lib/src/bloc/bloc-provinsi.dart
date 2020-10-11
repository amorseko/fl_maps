import 'package:fl_maps/src/model/model_provinsi.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetListProvinsiBloc {
  final _repository = Repository();
  final _GetListPronvisBloc = PublishSubject<GetListModelProvinsi>();

  Stream<GetListModelProvinsi> get getListProvince => _GetListPronvisBloc.stream;
  getListProvinsi(Function(GetListModelProvinsi model) callback) async {
    GetListModelProvinsi model = await _repository.fetchGetListProvinsi();
    _GetListPronvisBloc.sink.add(model);
    callback(model);
  }

  dispose() {
    _GetListPronvisBloc.close();
  }
}