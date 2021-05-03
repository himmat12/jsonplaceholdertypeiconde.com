import 'package:flutter/material.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/auth_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/helper/widget_builder_helper.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/service/img_service.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/service/user_service.dart';
import 'package:get_request_rest_api/enum.dart';
import 'package:get/get.dart';
import 'package:get_request_rest_api/service_locator.dart';

class Login extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  AuthController authController = Get.put(AuthController());

  final imgService = sl<ImgService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "NOTE*\n[ usercodes (1, 2, 3, 4, 5, 6, 7, 8, 9, 10) ]",
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "usercode",
              ),
            ),
            Obx(() => TextButton(
                  onPressed: () {
                    if (_controller.text.isEmpty != true) {
                      authController.login(id: _controller.text);
                    }
                  },
                  child: authController.userState.value == ViewState.BUSY
                      ? CircularProgressIndicator()
                      : Text("Proceed"),
                )),
          ],
        ),
      ),
    );
  }
}
