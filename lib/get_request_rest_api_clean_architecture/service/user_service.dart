import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/user_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/service/base_service.dart';

class UserService extends BaseService {
  //

  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];

    try {
      final response = await request(url: '/users', method: Requests.GET);
      if (response.statusCode == 200) {
        users = List.from(
            decodeResponse(response).map((e) => UserModel.fromJson(e)));

        return users;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserModel> getUser(int userId) async {
    List<UserModel> users;
    UserModel user;

    try {
      final response = await request(url: '/users', method: Requests.GET);
      if (response.statusCode == 200) {
        users = List.from(
            decodeResponse(response).map((e) => UserModel.fromJson(e)));
        if (userId != null) {
          user = users.firstWhere((e) => e.id == userId);
          return user;
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> auth(int id) async {
    List<UserModel> users = [];
    UserModel user;

    try {
      final response = await request(url: '/users', method: Requests.GET);

      if (response.statusCode == 200) {
        users = List.from(
            decodeResponse(response).map((e) => UserModel.fromJson(e)));
        // users.forEach((e) {
        //   print(e.id);
        // });
        if (id != null) {
          user = users.firstWhere((e) => e.id == id);
        }
        return {'status': true, 'data': user};
      } else {
        return {'status': false};
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
