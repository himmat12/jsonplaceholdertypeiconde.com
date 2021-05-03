import 'dart:async';
import 'dart:convert';

import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/utils/auth.dart';
import 'package:get_request_rest_api/main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

enum Requests { GET, POST, PUT, DELETE }

class BaseService {
  final box = GetStorage('auth');
  final client = http.Client();
  int _timeOutSeconds = 30;

  String getToken() {
    if (box.hasData('token')) {
      String token = box.read('token');
      return token;
    }

    return null;
  }

  Map<String, String> headers() {
    Map<String, String> _headers = {
      "content-type": "application/json",
    };
    if (box.hasData('token')) {
      String token = box.read('token');
      _headers['Authorization'] = "Token $token";
    }

    return _headers;
  }

  Future<http.Response> request({
    String url,
    Requests method,
    Map<String, dynamic> data,
  }) async {
    Uri _url = Uri.https(endPoint, url);
    http.Response response;

    switch (method) {
      case Requests.GET:
        response = await client
            .get(
          _url,
          headers: headers(),
        )
            .timeout(Duration(seconds: _timeOutSeconds), onTimeout: () {
          throw TimeoutException(
              "connection time out! please try again later ...");
        });
        break;

      case Requests.POST:
        response = await client
            .post(
          _url,
          headers: headers(),
          body: json.encode(data),
        )
            .timeout(Duration(seconds: _timeOutSeconds), onTimeout: () {
          throw TimeoutException(
              "connection time out! please try again later ...");
        });
        break;
      case Requests.PUT:
        response = await client
            .put(
          _url,
          headers: headers(),
          body: json.encode(data),
        )
            .timeout(Duration(seconds: _timeOutSeconds), onTimeout: () {
          throw TimeoutException(
              "connection time out! please try again later ...");
        });
        break;
      case Requests.DELETE:
        response = await client
            .delete(
          _url,
          headers: headers(),
          body: json.encode(data),
        )
            .timeout(Duration(seconds: _timeOutSeconds), onTimeout: () {
          throw TimeoutException(
              "connection time out! please try again later ...");
        });
        break;
      default:
        break;
    }

    print(response);
    print(response.statusCode);

    if (response.statusCode == 401) {
      Auth.logOut();

      return null;
    }

    return response;
  }

  dynamic decodeResponse(http.Response response) {
    return json.decode(utf8.decode(response.bodyBytes));
  }
  //
}
