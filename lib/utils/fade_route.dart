import 'package:flutter/cupertino.dart';

/**
 * @desc: 路由
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2020/1/31 0031 19:54
 * @UpdateUser： 更新者
 * @UpdateDate:     2020/1/31 0031 19:54
 * @UpdateRemark:   更新说明
 * @version:
 */
class FadeRoute extends PageRouteBuilder {

  final Widget page;
  FadeRoute({this.page}): super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>page,transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) =>FadeTransition(
    opacity: animation,
    child: child,
  ),
  );
}