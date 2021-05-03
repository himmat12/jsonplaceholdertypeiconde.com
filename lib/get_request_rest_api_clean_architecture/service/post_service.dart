import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/comment_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/post_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/service/base_service.dart';
import 'package:http/http.dart';

class PostService extends BaseService {
  List<PostModel> posts = [];
  List<CommentModel> comments = [];

  Future<List<CommentModel>> getComents(int postId) async {
    try {
      final response = await request(url: '/comments', method: Requests.GET);
      if (response.statusCode == 200) {
        comments = List.from(
            decodeResponse(response).map((e) => CommentModel.fromJson(e)));
        if (postId != null) {
          comments = comments.where((e) => e.postId == postId).toList();
          return comments;
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<PostModel>> getPosts() async {
    try {
      final response = await request(url: '/posts', method: Requests.GET);
      if (response.statusCode == 200) {
        posts = List.from(
            decodeResponse(response).map((e) => PostModel.fromJson(e)));
        // if (userId != null) {
        //   posts = posts.where((e) => e.userId == userId).toList();
        //   return posts;
        // }
        return posts;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
