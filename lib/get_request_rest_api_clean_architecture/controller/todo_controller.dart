import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/base_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/todo_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/service/todo_service.dart';
import 'package:get_request_rest_api/enum.dart';
import 'package:get_request_rest_api/service_locator.dart';
import 'package:get/get.dart';

class ToDoController extends BaseController {
  final toDoService = sl<ToDoService>();
  var toDos = <ToDoModel>[].obs;
  var toDoState = ViewState.IDLE.obs;
  var todo = ToDoModel().obs;

  completeToDo(ToDoModel todo) {
    todo.completed = true;
    update(['todo']);
  }

  getToDos({int userId}) async {
    toDoState.value = ViewState.BUSY;
    setState(ViewState.BUSY);
    await toDoService.getToDos(userId).then((value) {
      if (value != null) {
        toDos.value = value;
      }
    });
    setState(ViewState.RETRIVED);
    toDoState.value = ViewState.RETRIVED;
    update(['todo']);
  }
}
