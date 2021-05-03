import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/user_model.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage('auth');

class Auth {
  Auth() {
    box.write("token", "asd");
  }

  static bool get isLoggedIn => box.hasData('token');

  static setToken(String token) => box.write("token", token);
  static String get token => box.read('token');

  // static setUser(UserModel user) => box.write('user', user);

  // static UserModel get user => box.read('user');

  static steUserID(int userId) => box.write('userId', userId);
  static steUserProfile(String pathUrl) => box.write('pathUrl', pathUrl);
  static setFullName(String fullName) => box.write('fullName', fullName);
  static setUserName(String userName) => box.write('userName', userName);
  static setEmail(String email) => box.write('email', email);
  static setPhone(String phone) => box.write('phone', phone);

  static int get userId => box.read('userId');
  static String get userProfile => box.read('pathUrl');
  static String get fullName => box.read('fullName');
  static String get userName => box.read('userName');
  static String get email => box.read('email');
  static String get phone => box.read('phone');

  static logOut() => box.erase();
}
