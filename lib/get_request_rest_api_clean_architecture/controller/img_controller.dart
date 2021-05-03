import 'package:flutter/material.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/base_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/album_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/img_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/service/img_service.dart';
import 'package:get_request_rest_api/enum.dart';
import 'package:get_request_rest_api/service_locator.dart';
import 'package:get/get.dart';

class ImgController extends BaseController {
  ImgService _imgService = sl<ImgService>();
  var albums = <AlbumModel>[].obs;
  var images = <ImgModel>[].obs;

  var imgState = ViewState.IDLE.obs;
  var albumState = ViewState.IDLE.obs;

  var _isDefaultView = true.obs; //default view => Grid view

  bool get isDefaultView => _isDefaultView.value;

  toggleView() {
    _isDefaultView.value = !_isDefaultView.value;
  }

  clearData() {
    albums.clear();
    images.clear();
    print('albums cleared');
    print('albums length :${albums.length}');
    print(images.length);
  }

  getAlbum({int userId}) async {
    albumState.value = ViewState.BUSY;

    await _imgService.getALbum(userId).then((value) {
      if (value != null) {
        albums.value = value;
      }
    });
    albumState.value = ViewState.RETRIVED;

    update(['albumGallery']);
  }

  getImg({int albumId}) async {
    imgState.value = ViewState.BUSY;

    await _imgService.getImages(albumId).then((value) {
      if (value != null) {
        images.value = value;
      }
    });

    imgState.value = ViewState.RETRIVED;
    update(['imageGallery']);
  }
}
