import 'package:flutter/cupertino.dart';
/**
 * @desc: 作用描述
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2019/12/18 0018 16:27
 * @UpdateUser： 更新者
 * @UpdateDate:     2019/12/18 0018 16:27
 * @UpdateRemark:   更新说明
 * @version:
 */
class SearchPage  extends StatefulWidget{




  @override
  State<StatefulWidget> createState() {
    return new SearchPageState();
  }

  SearchPage(BuildContext context);

}

class SearchPageState extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('主页'),);
  }}