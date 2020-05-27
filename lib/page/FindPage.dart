import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/entity/FriendsDynamicEntity.dart';
import 'package:flutter_demo/widget/com_mom_bar.dart';
import 'package:flutter_demo/widget/load_view.dart';

import 'item_dynamic.dart';

/**
 * @desc: 作用描述
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2019/12/18 0018 16:23
 * @UpdateUser： 更新者
 * @UpdateDate:     2019/12/18 0018 16:23
 * @UpdateRemark:   更新说明
 * @version:
 */
class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new FindPageState();
  }
}

class FindPageState extends State<FindPage> {
  List<FriendsDynamicEntity> friendsDynamicEntity = [];

  double navAlpha = 0;
  double headerHeight;
  ScrollController scrollController = ScrollController();

  Color c = Colors.grey;
  String title = '';

  int maxImages = 9;

  @override
  void initState() {
    super.initState();
    getData();

    headerHeight = 250;

    scrollController.addListener((){
      var offset = scrollController.offset;
      if(offset<0){
        if(navAlpha!=0){
          setState(() =>navAlpha=0);
        }
      }else if(offset<headerHeight){
        if(headerHeight-offset<=navigationBarHeight(context)){
          setState(() {
            c =Colors.black;
            title ='朋友圈';
          });
        }else{
          c = Colors.transparent;
          title = '';
        }
        setState(() => navAlpha = 1 - (headerHeight - offset) / headerHeight);
      }else if(navAlpha!=1){
        setState(() => navAlpha = 1);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            controller: scrollController,
            child: Column(children: <Widget>[
              Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  Container(
                      child: ImageLoadView('https://hbimg.huabanimg.com/75ce9323b40dca6de90ad748ec7045644fc4007813277-Ys5rs0_fw658',
                          fit: BoxFit.cover,
                          height: headerHeight,
                          width: winWidth(context)),
                      margin: EdgeInsets.only(bottom: 30.0)),
                  Container(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10, right: 10),
                              child: Text('张三',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17)),
                            ),
                            ImageLoadView(
                              'http://cdn.duitang.com/uploads/item/201409/18/20140918141220_N4Tic.thumb.700_0.jpeg',
                              height: 70,
                              width: 70,
                              borderRadius: BorderRadius.circular(5.0),
                            )
                          ]),
                      margin: EdgeInsets.only(right: 10))
                ],
              ),
              SizedBox(height: 10),
              ListView.builder(
                  itemBuilder: (context, index) =>
                      ItemDynamic(friendsDynamicEntity[index]),
                  itemCount: friendsDynamicEntity.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false)
            ]),
          ),
          Container(
            height: navigationBarHeight(context)+10,
            child: new ComMomBar(
              title: title,
              rightDMActions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_a_photo,color: Color.fromRGBO(115, 115, 115, 1.0)),
                  onPressed: () => _showDialog(context),
                )
              ],
              backgroundColor:
              Color.fromARGB((navAlpha * 255).toInt(), 237, 237, 237),
            ),
          )
        ],
      ),
    );
  }

  void getData() async {

    rootBundle.loadString('assets/data/friends.json').then((value){
      friendsDynamicEntity = FriendsDynamicEntity.fromMapList(json.decode(value));
      setState(() {
      });
    });
  }
}

void _showDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(actions: <Widget>[
        CupertinoDialogAction(
          child: Text('拍摄', style: TextStyles.textBlue16),
          onPressed: () {
            /// TODO
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text('从相册选择', style: TextStyles.textBlue16),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text('取消', style: TextStyles.textRed16),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ]));
}


class TextStyles {
  static TextStyle textStyle(
      {double fontSize: Dimens.font_sp12,
        Color color: Colors.white,
        FontWeight fontWeight}) {
    return TextStyle(
        fontSize: fontSize,
        color: color,
        decoration: TextDecoration.none,
        fontWeight: fontWeight);
  }

  static TextStyle textWhite14 = textStyle(fontSize: Dimens.font_sp14);
  static TextStyle textRed14 =
  textStyle(fontSize: Dimens.font_sp14, color: Colors.red);

  static TextStyle textGrey14 =
  textStyle(fontSize: Dimens.font_sp14, color: Colors.grey);
  static TextStyle textDark14 =
  textStyle(fontSize: Dimens.font_sp14, color: Color(0xFF333333));
  static TextStyle textBoldDark14 = textStyle(
      fontSize: Dimens.font_sp14,
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle textBoldWhile14 =
  textStyle(fontSize: Dimens.font_sp14, fontWeight: FontWeight.bold);
  static TextStyle textBoldBlue14 = textStyle(
      fontSize: Dimens.font_sp14,
      fontWeight: FontWeight.bold,
      color: Colors.blueAccent);

  static TextStyle textReader16 =
  textStyle(fontSize: Dimens.font_sp16, color: Color(0xFF33C3A5));
  static TextStyle textRed16 =
  textStyle(fontSize: Dimens.font_sp16, color: Colors.red);
  static TextStyle textBlue16 =
  textStyle(fontSize: Dimens.font_sp16, color: Colors.blueAccent);
  static TextStyle textWhite16 = textStyle(fontSize: Dimens.font_sp16);
  static TextStyle textGreyC16 =
  textStyle(fontSize: Dimens.font_sp16, color: Color(0xFFCCCCCC));
  static TextStyle textGrey16 =
  textStyle(fontSize: Dimens.font_sp16, color: Colors.grey);
  static TextStyle textDark16 =
  textStyle(fontSize: Dimens.font_sp16, color: Color(0xFF333333));
}

class Dimens {
  static const double font_sp10 = 10;
  static const double font_sp12 = 12;
  static const double font_sp14 = 14;
  static const double font_sp16 = 16;
  static const double font_sp18 = 18;
  static const double font_sp20 = 20;
  static const double font_sp26 = 26;
  static const double font_sp40 = 40;

  static const double gap_dp3 = 3;
  static const double gap_dp4 = 4;
  static const double gap_dp5 = 5;
  static const double gap_dp6 = 6;
  static const double gap_dp8 = 8;
  static const double gap_dp10 = 10;
  static const double gap_dp12 = 12;
  static const double gap_dp15 = 15;
  static const double gap_dp16 = 16;
  static const double gap_dp20 = 20;
  static const double gap_dp24 = 24;
  static const double gap_dp25 = 25;
  static const double gap_dp40 = 40;
  static const double gap_dp48 = 48;
  static const double gap_dp60 = 60;

  static const double line_dp2 = 2;
  static const double line_dp1 = 1;
  static const double line_dp_half = 0.5;

  static const double homeImageSize = 27.0;

  static const double maxFontSize = 30.0;
  static const double minFontSize = 10.0;

  static const double minSpace = 1.0;
  static const double maxSpace = 3.0;

  static const double chapterItemHeight = 50.0;
}


double navigationBarHeight(BuildContext context) {
  return kToolbarHeight;
}

double winWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

