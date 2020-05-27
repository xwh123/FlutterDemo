import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/menu_item.dart';
/**
 * @desc: 其他界面
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2019/12/18 0018 16:23
 * @UpdateUser： 更新者
 * @UpdateDate:     2019/12/18 0018 16:23
 * @UpdateRemark:   更新说明
 * @version:
 */
class TodoPage  extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new TodoPageState();
  }

}

class TodoPageState extends State<TodoPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.0),
              color: Colors.white,
              child: MenuItem(title: '富文本编辑',),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              color: Colors.white,
              child: Column(
              children: <Widget>[
                 MenuItem(title: '扫一扫',
                  imagePath: 'images/icon_scan.png',),
                Padding(padding:  EdgeInsets.only(left: 15.0, right: 15.0),
                child: Divider(
                  height: 0.5,
                  color: Color(0xFFd9d9d9),
                ),)
              ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              color: Colors.white,
              child: MenuItem(title: '小说阅读',),
            ),
          ],
        ),
      ),
    );
  }
}