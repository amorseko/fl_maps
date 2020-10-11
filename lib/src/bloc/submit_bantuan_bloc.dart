import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:fl_maps/src/model/default_model.dart';

class bantuanBloc {
  final _repository = Repository();
  final _getDoBantuan = PublishSubject<DefaultModel>();

  Stream<DefaultModel> get getUploadImageProfile => _getDoBantuan.stream;

  doBantuan(FormData data, Function callback) async {
//    print(data);
    DefaultModel model = await _repository.submitBantuan(formData: data);
    _getDoBantuan.sink.add(model);
    callback(model);
  }

  dispose() {
    _getDoBantuan.close();
  }
}

final bloc = bantuanBloc();
