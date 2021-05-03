import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/post_controller.dart';
import 'package:get/get.dart';

class NavigatorController {
  var _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  setIndex(int index) {
    _currentIndex.value = index;
  }

  resetNavigation() {
    _currentIndex.value = 0;
  }
}
