import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/entity/article.dart';
import 'package:flutter_demo/entity/chapter.dart';
import 'package:flutter_demo/main.dart';
import 'package:flutter_demo/utils/Screen.dart';
import 'package:flutter_demo/utils/article_provider.dart';
import 'package:flutter_demo/utils/reader_config.dart';
import 'package:flutter_demo/utils/reader_page_agent.dart';
import 'package:flutter_demo/utils/reader_utils.dart';
import 'package:flutter_demo/utils/request.dart';
import 'package:flutter_demo/widget/reader_menu.dart';
import 'package:flutter_demo/widget/reader_view.dart';
import 'package:toast/toast.dart';

/**
 * @desc: 阅读小说界面
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2020/2/5 0005 17:02
 * @UpdateUser： 更新者
 * @UpdateDate:     2020/2/5 0005 17:02
 * @UpdateRemark:   更新说明
 * @version:
 */

enum PageType { stay, firstPage, lastPage }

class ReadNovelPage extends StatefulWidget {
  final int articleId;

  ReadNovelPage({this.articleId});

  @override
  State<StatefulWidget> createState() {
    return new _ReadNovelPageState();
  }
}

class _ReadNovelPageState extends State<ReadNovelPage> with RouteAware {
  int pageIndex = 0;
  bool isMenuVisiable = false;
  PageController _pageController = PageController(keepPage: false);
  bool isLoading = false;

  double topSafeHeight = 0;

  List<Chapter> chapters = [];

  Article preArticle;
  Article currentArticle;
  Article nextArticle;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(onScroll);
    setup();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPop() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  @override
  void dispose() {
    _pageController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  void setup() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    // 不延迟的话，安卓获取到的topSafeHeight是错的。
    await Future.delayed(const Duration(milliseconds: 100), () {});
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    topSafeHeight = Screen.topSafeHeight;
    List<dynamic> chaptersResponse = await Request.get(action: 'catalog');

    chaptersResponse.forEach((data) {
      chapters.add(Chapter.fromJson(data));
    });

    await resetContent(this.widget.articleId, PageType.stay);
  }

  resetContent(int articleId, PageType stay) async {
    currentArticle = await fetchArticle(articleId);

    if (currentArticle.preArticleId > 0) {
      preArticle = await fetchArticle(currentArticle.preArticleId);
    } else {
      preArticle = null;
    }

    if (currentArticle.nextArticleId > 0) {
      nextArticle = await fetchArticle(currentArticle.nextArticleId);
    } else {
      nextArticle = null;
    }
    if (stay == PageType.firstPage) {
      pageIndex = 0;
    } else if (stay == PageType.lastPage) {
      pageIndex = currentArticle.pageCount - 1;
    }
    if (stay != PageType.stay) {
      _pageController.jumpToPage(
          (preArticle != null ? preArticle.pageCount : 0) + pageIndex);
    }

    setState(() {});
  }

  void onScroll() {
    var page = _pageController.offset / Screen.width;

    var nextArtilePage = currentArticle.pageCount +
        (preArticle != null ? preArticle.pageCount : 0);
    if (page >= nextArtilePage) {
      print('到达下个章节了');

      preArticle = currentArticle;
      currentArticle = nextArticle;
      nextArticle = null;
      pageIndex = 0;
      _pageController.jumpToPage(preArticle.pageCount);
      fetchNextArticle(currentArticle.nextArticleId);
      setState(() {});
    }
    if (preArticle != null && page <= preArticle.pageCount - 1) {
      print('到达上个章节了');

      nextArticle = currentArticle;
      currentArticle = preArticle;
      preArticle = null;
      pageIndex = currentArticle.pageCount - 1;
      _pageController.jumpToPage(currentArticle.pageCount - 1);
      fetchPreviousArticle(currentArticle.preArticleId);
      setState(() {});
    }
  }

  void fetchPreviousArticle(int preArticleId) async {
    if (preArticle != null || isLoading || preArticleId == 0) {
      return;
    }
    isLoading = true;
    preArticle = await fetchArticle(preArticleId);
    _pageController.jumpToPage(preArticle.pageCount + pageIndex);
    isLoading = false;
    setState(() {});
  }

  void fetchNextArticle(int nextArticleId) async {
    if (nextArticle != null || isLoading || nextArticleId == 0) {
      return;
    }
    isLoading = true;
    nextArticle = await fetchArticle(nextArticleId);
    isLoading = false;
    setState(() {});
  }

  Future<Article> fetchArticle(int articleId) async {
    var article = await ArticleProvider.fetchArticle(articleId);
    var contentHeight = Screen.height -
        topSafeHeight -
        ReaderUtils.topOffset -
        Screen.bottomSafeHeight -
        ReaderUtils.bottomOffset -
        20;
    var contentWidth = Screen.width - 15 - 10;
    article.pageOffsets = ReaderPageAgent.getPageOffsets(article.content,
        contentHeight, contentWidth, ReaderConfig.instance.fontSize);

    return article;
  }

  onTap(Offset position) async {
    double xRate = position.dx / Screen.width;
    if (xRate > 0.33 && xRate < 0.66) {
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
      setState(() {
        isMenuVisiable = true;
      });
    } else if (xRate >= 0.66) {
      nextPage();
    } else {
      previousPage();
    }
  }

  onPageChanged(int index) {
    var page = index - (preArticle != null ? preArticle.pageCount : 0);
    if (page < currentArticle.pageCount && page >= 0) {
      setState(() {
        pageIndex = page;
      });
    }
  }

  previousPage() {
    if (pageIndex == 0 && currentArticle.preArticleId == 0) {
      Toast.show('已经是第一页了', context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return;
    }
    _pageController.previousPage(duration: Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  nextPage() {
    if (pageIndex >= currentArticle.pageCount - 1 && currentArticle.nextArticleId == 0) {
      Toast.show('已经是最后一页了', context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return;
    }
    _pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  Widget buildPage(BuildContext context, int index) {
    var page = index - (preArticle != null ? preArticle.pageCount : 0);
    var article;
    if (page >= this.currentArticle.pageCount) {
      // 到达下一章了
      article = nextArticle;
      page = 0;
    } else if (page < 0) {
      // 到达上一章了
      article = preArticle;
      page = preArticle.pageCount - 1;
    } else {
      article = this.currentArticle;
    }

    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        onTap(details.globalPosition);
      },
      child: ReaderView(article: article, page: page, topSafeHeight: topSafeHeight),
    );
  }

  buildPageView() {
    if (currentArticle == null) {
      return Container();
    }

    int itemCount = (preArticle != null ? preArticle.pageCount : 0) + currentArticle.pageCount + (nextArticle != null ? nextArticle.pageCount : 0);
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      controller: _pageController,
      itemCount: itemCount,
      itemBuilder: buildPage,
      onPageChanged: onPageChanged,
    );
  }

  buildMenu() {
    if (!isMenuVisiable) {
      return Container();
    }
    return ReaderMenu(
      chapters: chapters,
      articleIndex: currentArticle.index,
      onTap: hideMenu,
      onPreviousArticle: () {
        resetContent(currentArticle.preArticleId, PageType.firstPage);
      },
      onNextArticle: () {
        resetContent(currentArticle.nextArticleId, PageType.firstPage);
      },
      onToggleChapter: (Chapter chapter) {
        resetContent(chapter.id, PageType.firstPage);
      },
    );
  }

  hideMenu() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    setState(() {
      this.isMenuVisiable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentArticle == null || chapters == null) {
      return Scaffold();
    }

    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Stack(
          children: <Widget>[
            Positioned(left: 0, top: 0, right: 0, bottom: 0, child: Image.asset('img/read_bg.png', fit: BoxFit.cover)),
            buildPageView(),
            buildMenu(),
          ],
        ),
      ),
    );
  }

}
