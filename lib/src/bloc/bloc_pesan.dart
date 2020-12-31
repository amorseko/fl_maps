import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:fl_maps/src/model/default_model.dart';

class pesanBloc {
  final _repository = Repository();
  final _GetPesanBloc = PublishSubject<DefaultModel>();

  Stream<DefaultModel> get getPesanBloc => _GetPesanBloc.stream;

  doPesanBloc(FormData data, Function callback) async {
//    print(data);
    DefaultModel model = await _repository.submitPesan(formData: data);
    _GetPesanBloc.sink.add(model);
    callback(model);
  }

  dispose() {
    _GetPesanBloc.close();
  }
}

final bloc = pesanBloc();