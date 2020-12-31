import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:fl_maps/src/model/default_model.dart';

class UpdatePictBloc {
  final _repository = Repository();
  final _getDoUpdatePict = PublishSubject<DefaultModel>();

  Stream<DefaultModel> get getUploadImageProfile => _getDoUpdatePict.stream;

  doUpdatePictBloc(FormData data, Function callback) async {
//    print(data);
    DefaultModel model = await _repository.submitUpdatePict(formData: data);
    _getDoUpdatePict.sink.add(model);
    callback(model);
  }

  dispose() {
    _getDoUpdatePict.close();
  }
}

final bloc = UpdatePictBloc();