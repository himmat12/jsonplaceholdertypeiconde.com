import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/auth_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/img_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/navigator_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/user_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/pages/dsahborad/components/auth_info_breadcrum.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/pages/gallery/albums_gallery.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/pages/post_wall/post_wall.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/pages/profile/profile.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/pages/todo_wall/todo_wall.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/utils/auth.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  final UserModel user;
  final _navigatorController = Get.put(NavigatorController());
  final _authControler = Get.put(AuthController());
  final _imgController = Get.put(ImgController());

  Dashboard({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      AlbumGallery(),
      PostWall(),
      ToDOWall(),
      Profile(user: user),
    ];
    return WillPopScope(
      onWillPop: () async {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    exit(1);
                  },
                  child: Text('exit')),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('cancle')),
            ],
            content: Text('Do you want to exit?'),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("jsonplaceholder.typeicode"),
          actions: [
            TextButton(
                onPressed: () {
                  print("logout");
                  _authControler.logout();
                },
                child: Text(
                  'logout',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _navigatorController.currentIndex,
          onTap: (currentIndex) {
            _navigatorController.setIndex(currentIndex);
            // print(currentIndex);
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: "",
              icon: Text("Gallery"),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Text("Posts"),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Text("ToDo"),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Text("Profile"),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  authInfoBreadcrum(
                    email: Auth.email,
                    phone: Auth.phone,
                    user: Auth.userName,
                    name: Auth.fullName,
                  ),
                  // SizedBox(height: 12),
                  pages[_navigatorController.currentIndex],
                ],
              )),
        ),
      ),
    );
  }
}
