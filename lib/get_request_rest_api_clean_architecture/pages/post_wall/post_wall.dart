import 'package:flutter/material.dart';

import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/post_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/post_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/pages/post_wall/comments_wall.dart';
import 'package:get_request_rest_api/enum.dart';
import 'package:get/get.dart';

class PostWall extends StatelessWidget {
  final postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'posts',
      init: postController,
      initState: (_) {
        postController.getPosts();
      },
      builder: (_) {
        return Obx(() => postController.postsState.value != ViewState.RETRIVED
            ? Center(
                child: Text('initializing ...'),
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Text(
                    'Posts & Feeds',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 16,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: postController.count,
                    itemBuilder: (context, index) {
                      PostModel post = postController.posts[index];
                      return Container(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#${post.id}  ${post.title}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(post.body),
                            TextButton(
                              onPressed: () {
                                Get.to(
                                  CommentsWall(post: post),
                                );
                              },
                              child: Text('comments'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  postController.isCountMaxed.value == true
                      ? SizedBox()
                      : InkWell(
                          onTap: () {
                            postController.loadMore();
                            print('load more');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              border: Border(
                                top: BorderSide(
                                    color: Colors.black12, width: 0.5),
                                bottom: BorderSide(
                                    color: Colors.black12, width: 0.5),
                                left: BorderSide(
                                    color: Colors.black12, width: 0.5),
                                right: BorderSide(
                                    color: Colors.black12, width: 0.5),
                              ),
                            ),
                            alignment: Alignment.center,
                            height: 60,
                            child: postController.postsState.value !=
                                    ViewState.RETRIVED
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    'More',
                                    style: TextStyle(
                                      // color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),
                  SizedBox(height: 20),
                ],
              ));
      },
    );
  }
}
