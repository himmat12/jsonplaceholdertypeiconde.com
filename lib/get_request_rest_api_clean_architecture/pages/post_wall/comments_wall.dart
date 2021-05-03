import 'package:flutter/material.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/post_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/comment_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/post_model.dart';
import 'package:get/get.dart';

import '../../../enum.dart';

class CommentsWall extends StatelessWidget {
  final postController = Get.find<PostController>();
  final PostModel post;

  CommentsWall({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('#${post.id} comments'),
      ),
      body: GetBuilder(
        id: 'comments',
        init: postController,
        initState: (_) {
          postController.getComments(postId: post.id);
        },
        builder: (_) => postController.postsState.value != ViewState.RETRIVED
            ? Center(
                child: Text('initializing ...'),
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                children: [
                  Text(
                    'Comments',
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
                    itemCount: postController.comments.length,
                    itemBuilder: (context, index) {
                      CommentModel comment = postController.comments[index];
                      return Container(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#${comment.id}  ${comment.email}',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(comment.body),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
      ),
    );
  }
}
