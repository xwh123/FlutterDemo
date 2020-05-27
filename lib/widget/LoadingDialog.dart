import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * @desc: 加载提示框
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2019/12/19 0019 21:07
 * @UpdateUser： 更新者
 * @UpdateDate:     2019/12/19 0019 21:07
 * @UpdateRemark:   更新说明
 * @version:
 */
class LoadingDialog extends Dialog {
  final String text;

  LoadingDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
      //透明
      type: MaterialType.transparency,
      child: new Center(
        //SizedBox 创建固定大小的框。[宽度]和[高度]参数可以为空
        // 指示框的大小不应限制在相应的维度。
        child: new SizedBox(
          width: 120.0,
          height: 120.0,
          //ShapeDecoration：实现四个边分别指定颜色和宽度、底部线、矩形边色、圆形边色、体育场（竖向椭圆）、 角形（八边角）边色
          child: new Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            //垂直（Column）方向
            child: new Column(
              //MainAxisAlignment（主轴）就是与当前控件方向一致的轴,在水平方向控件中，例如Row
              //MainAxisAlignment是水平的，默认起始位置在左边，排列方向为从左至右，
              // 此时可以通过textDirection来改变MainAxisAlignment的起始位置和排列方向
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // CircularProgressIndicator:圆形进度条
                //可以在外面包一层SizedBox，间接改变进度条的大小
                new CircularProgressIndicator(),
                new Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: new Text(text),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
