import 'package:flutter/material.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/img_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/helper/widget_builder_helper.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/pages/gallery/images_gallery.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/utils/auth.dart';
import 'package:get_request_rest_api/enum.dart';
import 'package:get/get.dart';

class AlbumGallery extends StatelessWidget {
  final ImgController imgController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImgController>(
      id: 'albumGallery',
      init: imgController,
      initState: (_) {
        imgController.getAlbum(userId: Auth.userId);
      },
      builder: (_) {
        return Obx(
          () => imgController.albumState.value != ViewState.RETRIVED
              ? Center(
                  child: Text('initializing ...'),
                )
              : ListView(
                  padding: const EdgeInsets.all(12),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Text(
                      'Albums & Gallery',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: imgController.albums.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        mainAxisExtent: 56,
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          print('=> img gallery');
                          Get.to(ImageGallery(
                              albumId: imgController.albums[index].id));
                        },
                        child: GridTile(
                          header: Text(
                              'Album ID: ${imgController.albums[index].id}'),
                          footer: Text(
                            imgController.albums[index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          child: Container(
                            color: Colors.black12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
