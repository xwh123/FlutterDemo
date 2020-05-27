import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_demo/entity/article.dart';
import 'package:flutter_demo/utils/request.dart';

/**
 * @desc: 作用描述
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2020/2/5 0005 18:16
 * @UpdateUser： 更新者
 * @UpdateDate:     2020/2/5 0005 18:16
 * @UpdateRemark:   更新说明
 * @version:
 */
class ArticleProvider {

  static Future<Article> fetchArticle(int articleId) async {
    var response = await Request.get(action: 'article_$articleId');
    var article = Article.fromJson(response);

    return article;
  }

}