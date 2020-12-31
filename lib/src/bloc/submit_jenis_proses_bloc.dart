import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:fl_maps/src/model/default_model.dart';

class kinerjaBloc {
  final _repository = Repository();
  final _getDoKinerja = PublishSubject<DefaultModel>();

  Stream<DefaultModel> get getUploadImageProfile => _getDoKinerja.stream;

  doKinerjaBloc(FormData data, Function callback) async {
//    print(data);
    DefaultModel model = await _repository.submitJenisProses(formData: data);
    _getDoKinerja.sink.add(model);
    callback(model);
  }

  dispose() {
    _getDoKinerja.close();
  }
}

final bloc = kinerjaBloc();
