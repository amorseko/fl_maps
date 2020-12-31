import 'dart:convert';

import 'package:fl_maps/src/model/member_model.dart';
import 'package:fl_maps/src/resources/repository.dart';
import 'package:fl_maps/src/utility/SharedPreferences.dart';
import 'package:rxdart/rxdart.dart';

class DoLoginBloc {
  final _repository = Repository();
  final _doLogin = PublishSubject<MemberModels>();

//  Observable<MemberModels> get doRegistration =>
//      _doRegistrationFetch.stream;

  fetchDoLogin(Map<String, dynamic> body, Function callback) async {
    print(body);
    MemberModels model = await _repository.actLogin(body: body);
    if (model.data != null) {
      SharedPreferencesHelper.setDoLogin(json.encode(model.toJson()));
//      SharedPreferencesHelper.setToken(model.token);
    }
    callback(model.status, model.message, model.code);
  }

  dispose() {
    _doLogin.close();
  }
}

final bloc = DoLoginBloc();
