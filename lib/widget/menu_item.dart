import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/common/touch_callback.dart';
import 'package:flutter_demo/page/editor_page.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_demo/page/read_novel_page.dart';

/**
 * @desc: 条目item
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2020/2/1 0001 17:54
 * @UpdateUser： 更新者
 * @UpdateDate:     2020/2/1 0001 17:54
 * @UpdateRemark:   更新说明
 * @version:
 */
class MenuItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final Icon icon;

  MenuItem({Key key, @required this.title, this.imagePath, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchCallBack(
      onPressed: () {
        switch (title) {
          case '富文本编辑':
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => EditorPage()));
            break;

          case '扫一扫':
            scan();
            break;

          case '小说阅读':
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ReadNovelPage(articleId: 1000,)));
            break;
        }
      },
      child: Container(
        height: 50.0,
        child: Row(
          children: <Widget>[
            Container(
              child: imagePath != null
                  ? Image.asset(
                      imagePath,
                      width: 32.0,
                      height: 32.0,
                    )
                  : SizedBox(
                      height: 32.0,
                      width: 32.0,
                      child: icon,
                    ),
              margin: EdgeInsets.only(left: 22.0, right: 20.0),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 16.0, color: Color(0xFF353535)),
            )
          ],
        ),
      ),
    );
  }

  //  扫描二维码
  Future scan() async {
    try {
      // 此处为扫码结果，barcode为二维码的内容
      String barcode = await BarcodeScanner.scan();
      print('扫码结果: ' + barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        // 未授予APP相机权限
        print('未授予APP相机权限');
      } else {
        // 扫码错误
        print('扫码错误: $e');
      }
    } on FormatException {
      // 进入扫码页面后未扫码就返回
      print('进入扫码页面后未扫码就返回');
    } catch (e) {
      // 扫码错误
      print('扫码错误: $e');
    }
  }
}
