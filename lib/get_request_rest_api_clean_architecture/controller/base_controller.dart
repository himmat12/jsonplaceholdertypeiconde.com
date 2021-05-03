import 'package:get/get.dart';

import '../../enum.dart';

class BaseController extends GetxController {
  var _state = ViewState.IDLE.obs;

  ViewState get state => _state.value;

  void setState(ViewState currentState) {
    _state.value = currentState;
  }
}
