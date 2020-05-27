import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

/**
 * @desc: 图片查看
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2020/1/31 0031 17:13
 * @UpdateUser： 更新者
 * @UpdateDate:     2020/1/31 0031 17:13
 * @UpdateRemark:   更新说明
 * @version:
 */
class PictureView extends StatefulWidget {
  List images = [];
  int index = 0;
  String heroTag;
  PageController controller;

  PictureView(
      {Key key,
      @required this.images,
      this.index,
      this.controller,
      this.heroTag})
      : super(key: key) {
    controller = PageController(initialPage: index);
  }

  @override
  _PictureViewState createState() => _PictureViewState();
}

class _PictureViewState extends State<PictureView> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
                child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(widget.images[index]),
                );
              },
              itemCount: widget.images.length,
              loadingChild: Container(
                child: CachedNetworkImage(
                    imageUrl: widget.images[currentIndex],
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill),
              ),
              backgroundDecoration: null,
              pageController: widget.controller,
              enableRotation: true,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            )),
          ),
          Positioned(
            //图片index显示
            top: MediaQuery.of(context).padding.top + 15,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("${currentIndex + 1}/${widget.images.length}",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
          Positioned(
            //右上角关闭按钮
            right: 10,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
