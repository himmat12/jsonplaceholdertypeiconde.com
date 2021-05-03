import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/base_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/comment_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/post_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/user_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/service/post_service.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/service/user_service.dart';
import 'package:get_request_rest_api/enum.dart';
import 'package:get_request_rest_api/service_locator.dart';
import 'package:get/get.dart';

class PostController extends BaseController {
  final _postService = sl<PostService>();

  var posts = <PostModel>[].obs;
  var comments = <CommentModel>[].obs;
  var user = UserModel().obs;

  var postsState = ViewState.IDLE.obs;
  var commentsState = ViewState.IDLE.obs;

  var _count = 10.obs;

  int get count => _count.value;
  var isCountMaxed = false.obs;

  loadMore() {
    if (count < posts.length) {
      _count.value = _count.value + 10;
    }
    if (count == posts.length) {
      isCountMaxed.value = true;
    }
  }

  resetPostState() {
    _count.value = 10;
    isCountMaxed.value = false;
  }

  getPosts() async {
    postsState.value = ViewState.BUSY;
    await _postService.getPosts().then((value) {
      if (value != null) {
        posts.value = value;
      }
    });
    postsState.value = ViewState.RETRIVED;
    update(['posts']);
  }

  getComments({int postId}) async {
    commentsState.value = ViewState.BUSY;
    await _postService.getComents(postId).then((value) {
      if (value != null) {
        comments.value = value;
      }
    });
    commentsState.value = ViewState.RETRIVED;
    update(['comments']);
  }
}
