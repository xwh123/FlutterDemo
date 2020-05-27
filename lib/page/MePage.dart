import 'package:flutter/cupertino.dart';

/**
 * @desc: 作用描述
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2019/12/18 0018 16:24
 * @UpdateUser： 更新者
 * @UpdateDate:     2019/12/18 0018 16:24
 * @UpdateRemark:   更新说明
 * @version:
 */
class MePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new MePageState();
  }

}

class MePageState extends State<MePage>{
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('关于我'),);
  }

}