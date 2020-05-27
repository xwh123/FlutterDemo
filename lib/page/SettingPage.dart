import 'package:flutter/cupertino.dart';
/**
 * @desc: 作用描述
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2019/12/18 0018 16:28
 * @UpdateUser： 更新者
 * @UpdateDate:     2019/12/18 0018 16:28
 * @UpdateRemark:   更新说明
 * @version:
 */
class SettingPage  extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new SettingPageState();
  }

}

class SettingPageState extends State<SettingPage>{
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('设置'),);
  }
}