/**
 * @desc: 作用描述
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2019/12/18 0018 15:40
 * @UpdateUser： 更新者
 * @UpdateDate:     2019/12/18 0018 15:40
 * @UpdateRemark:   更新说明
 * @version:
 */
class LogUtils {
  ///打印日志
  static log(String str){
    if(str.isNotEmpty){
      print("yc---------" + str);
    }
  }

  ///打印日志
  static showPrint(String msg){
    if(msg!=null){
      print("yc---------" + msg);
    }
  }
}