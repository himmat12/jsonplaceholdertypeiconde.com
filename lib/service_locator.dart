import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/service/post_service.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/service/todo_service.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/service/user_service.dart';
import 'package:get_it/get_it.dart';

// import 'get_request_rest_api_clean_architecture/service/auth_service.dart';
import 'get_request_rest_api_clean_architecture/service/img_service.dart';

GetIt sl = GetIt.instance;

void setUp() {
  sl.registerLazySingleton<ImgService>(() => ImgService());
  sl.registerLazySingleton<UserService>(() => UserService());
  sl.registerLazySingleton<PostService>(() => PostService());
  sl.registerLazySingleton<ToDoService>(() => ToDoService());
}
