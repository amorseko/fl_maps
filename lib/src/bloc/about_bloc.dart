//import 'package:fl_maps/src/model/aboutus_model.dart';
//import 'package:fl_maps/src/resources/repository.dart';
//import 'package:rxdart/rxdart.dart';
//
//class AboutBloc {
//  final _repository = Repository();
//  final _aboutBloc = PublishSubject<AboutsModels>();
//
////  Observable<AboutsModels> get getaboutBloc => _aboutBloc.stream;
//  Stream<AboutsModels> get getaboutBloc => _aboutBloc.stream;
//  aboutBloc(Function(bool status, String message, AboutsModels model) callback) async {
//    AboutsModels model = await _repository.fetchAbout();
//    _aboutBloc.sink.add(model);
//    callback(model.error, model.message, model);
//  }
//
//  dispose() {
//    _aboutBloc.close();
//  }
//}
//
//final bloc = AboutBloc();
import 'package:fl_maps/src/model/aboutus_model.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class AboutBloc {
  final _repository = Repository();
  final _aboutBloc = PublishSubject<AboutsModels>();


  Stream<AboutsModels> get getaboutBloc => _aboutBloc.stream;
  aboutBloc(Map<String, dynamic> body,Function callback) async {
    AboutsModels model = await _repository.fetchAbout();
    _aboutBloc.sink.add(model);
//    print(model.data[0].info);
    callback(model.status, model.error, model.message, model);
  }

  dispose() {
    _aboutBloc.close();
  }

}
final bloc = AboutBloc();