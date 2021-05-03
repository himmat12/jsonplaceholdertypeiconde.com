import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/user_model.dart';

Widget authInfoBreadcrum({
  String email,
  String user,
  String name,
  String phone,
}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
    padding: const EdgeInsets.all(6),
    color: Colors.green.shade200,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('logged: $email'),
        Text('name: $name'),
        Text('user: $user'),
        Text('phone: $phone'),
      ],
    ),
  );
}
