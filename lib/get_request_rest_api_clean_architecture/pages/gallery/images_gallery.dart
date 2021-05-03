import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/img_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/helper/widget_builder_helper.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/img_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/utils/auth.dart';
import 'package:get_request_rest_api/enum.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';

class ImageGallery extends StatelessWidget {
  final int albumId;
  final ImgController imgController = Get.find();

  ImageGallery({Key key, this.albumId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album ID: ${albumId.toString()}'),
        actions: [
          IconButton(
            onPressed: () {
              imgController.toggleView();
            },
            icon: Obx(() => Icon(imgController.isDefaultView == true
                ? Icons.list
                : Icons.grid_view)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<ImgController>(
              id: 'imageGallery',
              init: imgController,
              initState: (_) {
                imgController.getImg(albumId: albumId);
              },
              builder: (_) {
                return Obx(
                  () => imgController.imgState.value != ViewState.RETRIVED
                      ? Center(
                          child: Text('initializing ...'),
                        )
                      : imgController.isDefaultView != true
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: imgController.images.length,
                              itemBuilder: (context, index) => ListTile(
                                onTap: () {
                                  showBottomSheet(
                                    context: context,
                                    builder: (context) => imgDetailsBuilder(
                                        imgController.images[index]),
                                  );
                                },
                                leading: FullScreenWidget(
                                  child: CachedNetworkImage(
                                    height: 40,
                                    width: 40,
                                    imageUrl: imgController
                                        .images[index].thumbnailUrl,
                                    placeholder: (context, url) => Container(
                                      color: Colors.black12,
                                    ),
                                  ),
                                ),
                                title: Text(imgController.images[index].title),
                                subtitle: Text(
                                    'img ID: ${imgController.images[index].id}'),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(12),
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: imgController.images.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                // mainAxisExtent: 56,
                              ),
                              itemBuilder: (context, index) => FullScreenWidget(
                                child: CachedNetworkImage(
                                  imageUrl: imgController.images[index].url,
                                  placeholder: (context, url) => Container(
                                    color: Colors.black12,
                                  ),
                                ),
                              ),
                            ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget imgDetailsBuilder(ImgModel image) => FullScreenWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: image.url,
            placeholder: (context, url) => Container(
              color: Colors.black12,
            ),
          ),
          Text('album ID: ${image.albumId}'),
          Text('img ID: ${image.id}'),
          Text('title: ${image.title}'),
          Text('thumbnail Url: ${image.thumbnailUrl}'),
          Text('url: ${image.url}'),
        ],
      ),
    );
