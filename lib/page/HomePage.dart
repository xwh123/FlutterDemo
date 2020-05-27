import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/Api.dart';
import 'package:flutter_demo/entity/BannerEntity.dart';
import 'package:flutter_demo/entity/CategoryEntity.dart';
import 'package:flutter_demo/entity/VideoEntity.dart';
import 'package:flutter_demo/page/VideoPlayPage.dart';
import 'package:flutter_demo/utils/HttpUtil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:toast/toast.dart';

/**
 * @desc: 首页
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2019/12/18 0018 16:22
 * @UpdateUser： 更新者
 * @UpdateDate:     2019/12/18 0018 16:22
 * @UpdateRemark:   更新说明
 * @version:
 */
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();

  //轮播图数据
  List<BannerData> bannerDatas = List();

  ScrollController _scrollController;

  //轮播图
  SwiperController _swiperController;

  int _page = 0;

  //分类数据
  List<CategoryData> categoryDatas = List();

  List<String> imageList = [
    'http:\/\/img-tailor.11222.cn\/pm\/book\/operate\/2019010321241999.jpg',
    "http:\/\/img-tailor.11222.cn\/pm\/book\/operate\/2019010320432795.jpg",
    "http:\/\/img-tailor.11222.cn\/pm\/book\/operate\/2019010220533196.jpg",
    "http:\/\/img-tailor.11222.cn\/pm\/book\/operate\/2018122921461175.jpg",
    "http:\/\/img-tailor.11222.cn\/pm\/book\/operate\/2018122913231050.jpg",
    "http:\/\/img-tailor.11222.cn\/pm\/book\/operate\/2018122823384358.jpg",
  ];

  String categoryJson =
      "[{\"title\":\"CandyShop\",\"imageUrl\":\"http:\/\/img-tailor.11222.cn\/pm\/book\/operate\/2019010321241999.jpg\"}"
      ",{\"title\":\"George\",\"imageUrl\":\"http:\/\/img-tailor.11222.cn\/pm\/book\/operate\/2019010320432795.jpg\"},"
      "{\"title\":\"Thomas\",\"imageUrl\":\"http:\/\/img-tailor.11222.cn\/pm\/book\/operate\/2018122921461175.jpg\"}]";

  //轮播图数据
  List<VideoResult> videoDatas = List();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() {});
    _swiperController = SwiperController();
    getData();
    getGridViewData();
    getVideoData();
  }

  void getData() async {
    try {
      var bannerResponse = await HttpUtil().get(Api.BANNER);
      Map bannerMap = json.decode(bannerResponse.toString());
      BannerEntity bannerEntity = BannerEntity.fromJson(bannerMap);

      setState(() {
        bannerDatas = bannerEntity.data;
        for (var i = 0; i < bannerDatas.length; i++) {
          if (i < imageList.length) {
            bannerDatas[i].imagePath = imageList[i];
          } else {
            bannerDatas[i].imagePath = imageList[1];
          }
        }
        ;
      });
      //轮播图自动播放
      _swiperController.startAutoplay();
    } catch (e) {
      print("获取轮播图出错===$e");
    }
  }

  //获取gridview 数据
  getGridViewData() async {
    setState(() {
      List categoryList = json.decode(categoryJson);
      categoryDatas =
          categoryList.map((m) => new CategoryData.fromJson(m)).toList();
    });
  }

  void getVideoData() async {
    var videoResponse = await HttpUtil().get(Api.INDEX_VIDEO_LIST);
    Map videoMap = json.decode(videoResponse.toString());
    VideoEntity videoEntity = VideoEntity.fromJson(videoMap);
    setState(() {
      videoDatas = videoEntity.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new EasyRefresh(
      refreshHeader: MaterialHeader(),
      refreshFooter: MaterialFooter(),
      key: _easyRefreshKey,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index == 0) {
                return getBanner();
              }
              return null;
            }),
          ),
          SliverGrid(
            //横轴数量 这里的横轴就是x轴 因为方向是垂直的时候 主轴是垂直的
            delegate: SliverChildBuilderDelegate((context, index) {
              return new Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.center,
                //垂直布局
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.network(
                        categoryDatas[index].imageUrl,
                      ),
                    ),
                    new Container(
                      alignment: Alignment.center,
                      child: new Text(
                        categoryDatas[index].title,
                        style: TextStyle(color: Colors.grey),
                      ),
                      padding: const EdgeInsets.only(top: 8.0),
                    ),
                  ],
                ),
              );
            }, childCount: categoryDatas.length),

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return new Container(
                  padding: EdgeInsets.only(left: 6, bottom: 6, right: 6),
                  child: new GestureDetector(
                    child: Row(
                      //CrossAxisAlignment.center：子组件在 Row 中居中对齐
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(400),
                          height: ScreenUtil().setHeight(300),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: Image.network(
                              videoDatas[index].data.content.data.cover.detail,
                            ),
                          ),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(600),
                          padding: EdgeInsets.only(left: 4),
                          child: Text(
                            videoDatas[index].data.content.data.title,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // 跳转播放视频
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoPlayPage(
                                videoUrl:
                                    videoDatas[index].data.content.data.playUrl,
                                title:
                                    videoDatas[index].data.content.data.title,
                              )));
                    },
                  ),
                );
              },
              childCount: videoDatas.length,
            ),
          ),
        ],
      ),
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _page = 0;
          });
          getData();
          getGridViewData();
        });
      },
      loadMore: () async {
        await Future.delayed(Duration(seconds: 1), () {
          setState(() {});
        });
      },
    );
  }

  Widget getWidgetGridViewItem(CategoryData categoryData) {
    return InkWell(
      child: Column(
        children: <Widget>[
          Image.network(
            categoryData.imageUrl,
            width: ScreenUtil().setWidth(120),
          ),
          Text(categoryData.title),
        ],
      ),
    );
  }

  Widget getBanner() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 10.0),
      height: 180.0,
      child: bannerDatas.length > 0
          ? Swiper(
              itemBuilder: (BuildContext content, int index) {
                return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.network(bannerDatas[index].imagePath,
                              fit: BoxFit.cover),
                        ],
                      ),
                    ));
              },
              itemCount: bannerDatas.length,
              pagination: new SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.black38,
                    activeColor: Colors.blueAccent,
                  ),
                  margin: const EdgeInsets.only(bottom: 22.0)),
              control: null,
              duration: 300,
              scrollDirection: Axis.horizontal,
              viewportFraction: 0.8,
              autoplayDisableOnInteraction: true,
              scale: 0.85,
              loop: true,
              autoplay: false,
              controller: _swiperController)
          : new Container(height: 0,),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _swiperController.stopAutoplay();
    _swiperController.dispose();
    super.dispose();
  }
}
