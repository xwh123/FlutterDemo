import 'package:flutter_demo/entity/BannerEntity.dart';

/**
 * @desc: 分类
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2019/12/31 0031 14:28
 * @UpdateUser： 更新者
 * @UpdateDate:     2019/12/31 0031 14:28
 * @UpdateRemark:   更新说明
 * @version:
 */
class CategoryEntity {
  List<CategoryData> data;

  CategoryEntity(this.data);

  CategoryEntity.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      data = new List<CategoryData>();
      (json as List).forEach((v) {
        data.add(new CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }


}

class CategoryData {
  String imageUrl;
  String title;

  CategoryData(this.imageUrl, this.title);

  CategoryData.fromJson(Map<String, dynamic> json) {
    imageUrl = json["imageUrl"];
    title = json["title"];
  }

  Map<String, dynamic> toJson() {
    return {
      "imageUrl": this.imageUrl,
      "title": this.title,
    };
  }
}
