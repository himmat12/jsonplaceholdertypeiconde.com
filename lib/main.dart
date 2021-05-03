import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/auth_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/pages/dsahborad/dashboard.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/utils/auth.dart';
import 'package:get_request_rest_api/dating_app_widgets/swipable_card.dart';
import 'package:get_request_rest_api/service_locator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'get_request_rest_api_clean_architecture/pages/login/login.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // service locater -get_it
  setUp();

// get storage
  await GetStorage.init('auth');

  return runApp(MyApp());
}

String endPoint = "jsonplaceholder.typicode.com";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (Auth.isLoggedIn == true) {
        Get.offAll(Dashboard());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'jsonplaceholdertypeicode.com',
      debugShowCheckedModeBanner: false,
      home:
          Login(), //rest api research / practice with maintaining clean code architecture

      // home: SwipableCard(),
    );
  }
}
