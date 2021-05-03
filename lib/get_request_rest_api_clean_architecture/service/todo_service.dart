import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/todo_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/service/base_service.dart';

class ToDoService extends BaseService {
  List<ToDoModel> toDos = [];

  Future getToDos(int userId) async {
    try {
      final response = await request(url: '/todos', method: Requests.GET);

      if (response.statusCode == 200) {
        toDos = List.from(
            decodeResponse(response).map((e) => ToDoModel.fromJson(e)));

        if (userId != null) {
          toDos = toDos.where((e) => e.userId == userId).toList();
          return toDos;
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
