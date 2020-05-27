/**
 * @desc: 作用描述
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2020/2/5 0005 17:35
 * @UpdateUser： 更新者
 * @UpdateDate:     2020/2/5 0005 17:35
 * @UpdateRemark:   更新说明
 * @version:
 */
class Article {

  int id;
  int novelId;
  String title;
  String content;
  int price;
  int index;
  int nextArticleId;
  int preArticleId;

  List<Map<String, int>> pageOffsets;

  Article.fromJson(Map data) {
    id = data['id'];
    novelId = data['novel_id'];
    title = data['title'];
    content = data['content'];
    content = '　　' + content;
    content = content.replaceAll('\n', '\n　　');
    price = data['welth'];
    index = data['index'];
    nextArticleId = data['next_id'];
    preArticleId = data['prev_id'];
  }

  String stringAtPageIndex(int index) {
    var offset = pageOffsets[index];
    return this.content.substring(offset['start'], offset['end']);
  }

  int get pageCount {
    return pageOffsets.length;
  }

}