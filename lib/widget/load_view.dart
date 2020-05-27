import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/picture_view.dart';

/**
 * @desc: 作用描述
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2020/1/26 0026 16:33
 * @UpdateUser： 更新者
 * @UpdateDate:     2020/1/26 0026 16:33
 * @UpdateRemark:   更新说明
 * @version:
 */
enum ImageType { network, assets, localFile }

class ImageLoadView extends StatelessWidget {
  /// 图片URL
  final String path;

  /// 宽
  final double width;

  /// 高
  final double height;

  /// 填充效果
  final BoxFit fit;

  /// 圆角
  final BorderRadius borderRadius;

  ImageLoadView(
    this.path, {
    Key key,
    this.width,
    this.height,
    this.fit: BoxFit.fill,
    this.borderRadius: const BorderRadius.all(Radius.circular(0.0)),
  }) : assert(path != null);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
          imageUrl: path, height: height, width: width, fit: fit),
    );
  }
}
