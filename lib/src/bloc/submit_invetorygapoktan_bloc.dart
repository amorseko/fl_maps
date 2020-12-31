import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:fl_maps/src/model/default_model.dart';

class invetoryBloc {
  final _repository = Repository();
  final _getDoInventoryBloc = PublishSubject<DefaultModel>();

  Stream<DefaultModel> get getUploadData => _getDoInventoryBloc.stream;

  doinvetoryBloc(FormData data, Function callback) async {
//    print(data);
    DefaultModel model = await _repository.submitInvetoryGapoktan(formData: data);
    _getDoInventoryBloc.sink.add(model);
    callback(model);
  }

  dispose() {
    _getDoInventoryBloc.close();
  }
}

final bloc = invetoryBloc();
