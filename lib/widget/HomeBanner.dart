import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/BannerEntity.dart';
import 'package:flutter_demo/utils/Screen.dart';

/**
 * @desc: 首页轮播图
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2019/12/31 0031 22:47
 * @UpdateUser： 更新者
 * @UpdateDate:     2019/12/31 0031 22:47
 * @UpdateRemark:   更新说明
 * @version:
 */
class HomeBanner extends StatelessWidget {
  final List<BannerData> bannerDatas;

  HomeBanner(this.bannerDatas);

  @override
  Widget build(BuildContext context) {
    if (bannerDatas.length == 0) {
      return SizedBox();
    }

    return Container(
      color: Colors.white,
      child: CarouselSlider(
        items: bannerDatas.map((info) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: Screen.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.network(info.imagePath??'',fit: BoxFit.cover,),
                ),
              );
            },
          );
        }).toList(),
        aspectRatio: 2,
        autoPlay: true,
      ),
    );
  }
}