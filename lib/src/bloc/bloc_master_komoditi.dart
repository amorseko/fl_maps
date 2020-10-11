import 'package:fl_maps/src/model/model_master_komoditi.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetListMasterKomoditiBloc {
  final _repository = Repository();
  final _GetListMasterKomoditiBloc = PublishSubject<GetListModelMasterKomoditi>();

  Stream<GetListModelMasterKomoditi> get getListMasterKomoditis => _GetListMasterKomoditiBloc.stream;
  getListMasterKomoditi(Function(GetListModelMasterKomoditi model) callback) async {
    GetListModelMasterKomoditi model = await _repository.fetchGetMasterKomoditi();
    _GetListMasterKomoditiBloc.sink.add(model);
    callback(model);
  }

  dispose() {
    _GetListMasterKomoditiBloc.close();
  }
}