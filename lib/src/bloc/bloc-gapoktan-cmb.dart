import 'package:fl_maps/src/model/model_gapoktan.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetListGapoktanCmbBloc {
  final _repository = Repository();
  final _GetListGapoktanCmbBloc = PublishSubject<GetModelGapoktan>();

  Stream<GetModelGapoktan> get getListGapoktanCmb => _GetListGapoktanCmbBloc.stream;
  getListGapoktanBlocCmb(Function(GetModelGapoktan model) callback) async {
    GetModelGapoktan model = await _repository.getListGapoktan();
    _GetListGapoktanCmbBloc.sink.add(model);
    callback(model);
  }

  dispose() {
    _GetListGapoktanCmbBloc.close();
  }
}