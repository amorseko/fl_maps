import 'package:fl_maps/src/model/standart_model.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ChangeProfileBloc{
  final _repository = Repository();
  final _changeProfile = PublishSubject<StandartModels>();

  actChangeProfile(Map<String, dynamic> body, Function callback) async {
    StandartModels model = await _repository.actChangeProfileUser(body: body);
    callback(model.status, model.message);
  }

  dispose() {
    _changeProfile.close();
  }
}

final bloc = ChangeProfileBloc();