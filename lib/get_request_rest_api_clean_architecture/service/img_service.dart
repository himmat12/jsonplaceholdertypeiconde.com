import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/album_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/img_model.dart';
import 'package:get_request_rest_api/main.dart';

import 'base_service.dart';

class ImgService extends BaseService {
  //
  List<AlbumModel> albums = [];
  List<ImgModel> images = [];

  Future<List<AlbumModel>> getALbum(int userId) async {
    try {
      final response = await request(url: '/albums', method: Requests.GET);
      if (response.statusCode == 200) {
        print('status ok');
        if (userId != null) {
          albums = List.from(
              decodeResponse(response).map((e) => AlbumModel.fromJson(e)));
          albums = albums.where((e) => e.userId == userId).toList();
          // print(albums.length);
          // albums.forEach((e) {
          //   print(e.id);
          // });
          return albums;
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<ImgModel>> getImages(int albumId) async {
    try {
      final response = await request(url: '/photos', method: Requests.GET);
      if (response.statusCode == 200) {
        images = List.from(
            decodeResponse(response).map((e) => ImgModel.fromJson(e)));
        if (albumId != null) {
          images = images.where((value) => value.albumId == albumId).toList();
          // images.forEach((e) {
          //   print(e.id);
          // });
          return images;
        }
        return null;
      }
      return null;
    } catch (e) {
      print("error ==>> $e");
      return null;
    }
  }
}
