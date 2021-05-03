import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/base_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/img_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/navigator_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/post_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/user_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/pages/dsahborad/dashboard.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/pages/login/login.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/service/user_service.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/utils/auth.dart';
import 'package:get_request_rest_api/enum.dart';
import 'package:get_request_rest_api/service_locator.dart';
import 'package:get/get.dart';

class AuthController extends BaseController {
  final imgController = Get.put(ImgController());
  final navController = Get.put(NavigatorController());
  final postController = Get.put(PostController());
  final userService = sl<UserService>();
  var userState = ViewState.IDLE.obs;

  UserModel user; // stores any users data

  // getUser({int userId}) async {
  //   userState.value = ViewState.BUSY;
  //   await userService.getUser(userId).then((value) {
  //     if (value != null) {
  //       user = value;
  //       return user;
  //     }
  //     return null;
  //   });
  //   userState.value = ViewState.RETRIVED;
  // }

  login({String id}) async {
    userState.value = ViewState.BUSY;

    await userService.auth(int.parse(id)).then((value) {
      if (value != null) {
        if (value['status'] == true) {
          user = value['data'];

          print(user.name);

          Auth.setToken(user.id.toString());
          // Auth.setUser(user);

          Auth.steUserID(user.id);
          Auth.setUserName(user.username);
          Auth.setFullName(user.name);
          Auth.setEmail(user.email);
          Auth.setPhone(user.phone);
          // Auth.steUserProfile('#');

          postController.resetPostState();
          navController.resetNavigation();
          Get.offAll(Dashboard(user: user));
        }
        // if (value['status'] == false) {
        //   return Get.snackbar('auth failed',
        //       'either your input field is empty or usercode didnot matched/exist ...');
        // }
      }
    });

    userState.value = ViewState.RETRIVED;
  }

  logout() {
    imgController.clearData();
    Auth.logOut();
    Get.offAll(Login());
  }
}
