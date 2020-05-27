
/**
 * @desc: 轮播图实体类
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2019/12/22 0022 17:59
 * @UpdateUser： 更新者
 * @UpdateDate:     2019/12/22 0022 17:59
 * @UpdateRemark:   更新说明
 * @version:
 */
class BannerEntity {
  List<BannerData> data;
  int errorCode;
  String errorMsg;

  BannerEntity({this.data, this.errorCode, this.errorMsg});

  BannerEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<BannerData>();
      (json['data'] as List).forEach((v) {
        data.add(new BannerData.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class BannerData {
  String imagePath;
  int id;
  int isVisible;
  String title;
  int type;
  String url;
  String desc;
  int order;

  BannerData(this.imagePath, this.id, this.isVisible, this.title, this.type,
      this.url, this.desc, this.order);

  BannerData.fromJson(Map<String, dynamic> json) {
    imagePath = json["imagePath"];
    id = json["id"];
    isVisible = json["isVisible"];
    title = json["title"];
    type = json["type"];
    url = json["url"];
    desc = json["desc"];
    order = json["order"];
  }

  Map<String, dynamic> toJson() {
    return {
      "imagePath": this.imagePath,
      "id": this.id,
      "isVisible": this.isVisible,
      "title": this.title,
      "type": this.type,
      "url": this.url,
      "desc": this.desc,
      "order": this.order,
    };
  }
}
