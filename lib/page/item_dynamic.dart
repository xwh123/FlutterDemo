import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/FriendsDynamicEntity.dart';
import 'package:flutter_demo/utils/fade_route.dart';
import 'package:flutter_demo/utils/friend_pop.dart';
import 'package:flutter_demo/widget/load_view.dart';
import 'package:flutter_demo/widget/picture_view.dart';
import 'package:flutter_demo/widget/single_picture_view.dart';
import 'package:toast/toast.dart';

/**
 * @desc: 作用描述
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2020/1/26 0026 16:35
 * @UpdateUser： 更新者
 * @UpdateDate:     2020/1/26 0026 16:35
 * @UpdateRemark:   更新说明
 * @version:
 */
class ItemDynamic extends StatelessWidget {
  final FriendsDynamicEntity dynamic;

  List<String> imgs = [];

  ItemDynamic(this.dynamic, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int imageSize = this.dynamic.images.length;

    double imageWidth = (winWidth(context) - 20 - 50 - 10) /
        ((imageSize == 3 || imageSize > 4)
            ? 3.0
            : (imageSize == 2 || imageSize == 4) ? 2.0 : 1.5);

    double videoWidth = (winWidth(context) - 20 - 50 - 10) / 2.2;

    String desc = this.dynamic.desc;

    String def =
        'https://c-ssl.duitang.com/uploads/item/201803/04/20180304085215_WGFx8.thumb.700_0.jpeg';

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ImageLoadView(
              '${this.dynamic?.userAvatar ?? def}',
              height: 50,
              width: 50,
              borderRadius: BorderRadius.circular(5.0),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 10.0, top: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// 发布者昵称
                        Text('${this.dynamic.username}'),

                        /// 发布的文字描述
                        Offstage(
                            offstage: desc.isEmpty,
                            child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text('$desc',
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis))),

                        /// 图片区域
                        Offstage(
                            offstage: imageSize == 0,
                            child: imageSize > 1
                                ? GridView.builder(
                                    padding: EdgeInsets.only(top: 8.0),
                                    itemCount: imageSize,
                                    shrinkWrap: true,
                                    primary: false,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: imageWidth,
                                            crossAxisSpacing: 2.0,
                                            mainAxisSpacing: 2.0,
                                            childAspectRatio: 1),
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          child: ImageLoadView(
                                            '${this.dynamic.images.isNotEmpty ? this.dynamic.images[index].image : def}',
                                            fit: BoxFit.cover,
                                            width: imageWidth,
                                            height: imageWidth,
                                          ),
                                          onTap: () {
                                            //FadeRoute是自定义的切换过度动画（渐隐渐现） 如果不需要 可以使用默认的MaterialPageRoute
                                            this.dynamic.images.forEach((f) {
                                              imgs.add(f.image);
                                            });
                                            Navigator.of(context)
                                                .push(new FadeRoute(
                                                    page: PictureView(
                                              images: imgs, //传入图片list
                                              index: index, //传入当前点击的图片的index
                                            )));
                                          },
                                        ))
                                : imageSize == 1
                                    ? Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: GestureDetector(
                                          child: ImageLoadView(
                                            this
                                                    .dynamic
                                                    ?.images
                                                    ?.first
                                                    ?.image ??
                                                def,
                                            width: imageWidth,
                                            height: imageWidth,
                                            fit: BoxFit.cover,
                                          ),
                                          onTap: () {
                                            Toast.show("跳转单图预览", context,
                                                duration: Toast.LENGTH_SHORT,
                                                gravity: Toast.BOTTOM);
                                            Navigator.of(context)
                                                .push(new FadeRoute(
                                                    page: SinglePictureView(
                                              imageProvider: NetworkImage(
                                                this
                                                    .dynamic
                                                    ?.images
                                                    ?.first
                                                    ?.image ??
                                                def,),
                                            )));
                                          },
                                        ))
                                    : SizedBox()),

                        /// 视频区域
                        Offstage(
                            offstage: this.dynamic.video == null,
                            child: Container(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    ImageLoadView(
                                      '${this.dynamic.video?.image ?? def}',
                                      height: 200,
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.play_arrow,
                                            color: Colors.blue),
                                        onPressed: () {})
                                  ],
                                ),
                                width: videoWidth)),

                        /// 定位地址
                        Offstage(
                            offstage: imageSize % 2 == 0,
                            child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text('${this.dynamic.address}',
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 13)))),

                        /// 发布时间
                        Row(children: <Widget>[
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('${this.dynamic.datetime}',
                                    style: TextStyle(
                                        color: Colors.grey[500], fontSize: 13)),
                                Offstage(
                                    offstage: !this.dynamic.isSelf,
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text('删除',
                                            style: TextStyle(
                                                color: Colors.blueAccent))))
                              ]),
                          TestPush(),
                        ], mainAxisAlignment: MainAxisAlignment.spaceBetween),

                        /// 评论部分
                      ])),
            )
          ],
        ),
        Container(
            height: 0.5,
            color: Colors.grey[200],
            margin: EdgeInsets.only(top: 10))
      ]),
    );
  }
}

class TestPush extends StatefulWidget {
  @override
  _TestPushState createState() => _TestPushState();
}

class _TestPushState extends State<TestPush> {
  Widget _buildExit() {
    TextStyle labelStyle = TextStyle(color: Colors.white);
    return Container(
      width: 200,
      height: 36,
      decoration: BoxDecoration(
        color: Color.fromRGBO(75, 75, 75, 1.0),
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new FlatButton(
              onPressed: () {
                Toast.show("点赞", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              },
              child: new Text('赞', style: labelStyle),
            ),
          ),
          new Expanded(
            child: new FlatButton(
              onPressed: () {
                Toast.show("评论一条信息", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              },
              child: new Text('评论', style: labelStyle),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.more_horiz, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            PopRoute(
              child: Popup(
                btnContext: context,
                child: _buildExit(),
                onClick: () {
                  print("exit");
                },
              ),
            ),
          );
        });
  }
}

double winWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
