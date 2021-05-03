import 'package:flutter/material.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/user_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/utils/auth.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class Profile extends StatelessWidget {
  final UserModel user;

  const Profile({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Text('user ID: ${Auth.userId}'),
        Text('name: ${Auth.fullName}'),
        Text('username: ${Auth.userName}'),
        Text('phone: ${Auth.phone}'),
        Text('email: ${Auth.email}'),
        SizedBox(height: 12),
        Text(
          'NOTE*\n[ other user info can also be consumed in our view but for now these few infos are sufficient ATM yo can check other user infos at https://jsonplaceholder.typicode.com/ ]',
          style: TextStyle(color: Colors.blue),
        ),
        SizedBox(height: 12),
        Text(
          "NOTE*\n[ this is simple GET request from REST API in (flutter/dart) the api service provider is (https://jsonplaceholder.typicode.com/),main reason why this project exists is simple this project's src is managed in clean architecture if you are a flutter begginners looking for some example srcs to learn then this might be the thing what you are searching for \n\nrequired dependencies:\n(cached_network_image, carousel_pro, cupertino_icons, flutter_tindercard, full_screen_image, get, get_it, get_storage, http) ]",
          style: TextStyle(color: Colors.blue),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
