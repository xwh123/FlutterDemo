import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/page/LoginPage.dart';
import 'package:flutter_demo/page/MyHomePage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';

/**
 * @desc: 作用描述
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2019/12/18 0018 10:41
 * @UpdateUser： 更新者
 * @UpdateDate:     2019/12/18 0018 10:41
 * @UpdateRemark:   更新说明
 * @version:
 */
class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _SplashPage();
  }
}

class _SplashPage extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return new Container(
      child: new Image.asset(
        'images/splash.png',
        fit: BoxFit.fill,
      ),
    );
  }

  //页面初始化状态的方法
  @override
  void initState() {
    super.initState();
    countDown();
  }

  void countDown() {
    //设置倒计时三秒后执行跳转方法
    var duration = new Duration(seconds: 2);
    new Future.delayed(duration, goToHomePage);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void goToHomePage() {
    //跳转主页 且销毁当前页面
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) => new LoginPage()),
        (Route<dynamic> rout) => false);
  }
}
