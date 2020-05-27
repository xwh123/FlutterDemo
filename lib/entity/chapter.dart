/**
 * @desc: 作用描述
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2020/2/5 0005 17:11
 * @UpdateUser： 更新者
 * @UpdateDate:     2020/2/5 0005 17:11
 * @UpdateRemark:   更新说明
 * @version:
 */
class Chapter {

  int id;
  String title;
  int index;

  Chapter.fromJson(Map data) {
    id = data['id'];
    title = data['title'];
    index = data['index'];
  }

}