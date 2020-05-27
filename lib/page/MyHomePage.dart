import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/Constants.dart';
import 'package:flutter_demo/res/MyColors.dart';
import 'package:flutter_demo/utils/EventBus.dart';
import 'package:flutter_demo/utils/LogUtils.dart';
import 'package:flutter_demo/widget/SmartDrawer.dart';
import 'package:toast/toast.dart';

import 'AboutMePage.dart';
import 'FindPage.dart';
import 'HomePage.dart';
import 'MePage.dart';
import 'SearchPage.dart';
import 'SettingPage.dart';
import 'TodoPage.dart';

/**
 * @desc: 主页
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2019/12/18 0018 11:03
 * @UpdateUser： 更新者
 * @UpdateDate:     2019/12/18 0018 11:03
 * @UpdateRemark:   更新说明
 * @version:
 */
class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  dynamic d = 1;

  //变量 默认索引
  int positionIndex = 0;

  //底部导航栏
  var mainTitles = ['首页', '发现', '其他', '我的'];
  var indexStack;

  //底部导航栏 item
  List<BottomNavigationBarItem> navigationViews;
  final navigatorKey = GlobalKey<NavigatorState>();

  //重写该方法，初始化作用
  @override
  Widget build(BuildContext context) {
    initData();
    return new MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
          accentColor: Colors.black,
          textSelectionColor: MyColors.colorWhite,
          primaryColor: MyColors.colorPrimary),
      //设置home
      home: new Scaffold(
        //设置appBar
//        appBar: initAppBar(),
        //不适用appbar  预留出告诉  避免内容溢出
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.7),
          child: SafeArea(
            top: true,
            child: Offstage(),
          ),
        ),
        //初始化侧滑菜单
//        drawer: initDrawer(), //New
        //body主题内容
        body: indexStack,
        //相当于底部导航栏
        bottomNavigationBar: initNavigationBar(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    initNavigationBarView();
    initNavigationBar();
    LogUtils.showPrint('initState');
  }

  @override
  void didChangeDependencies() {
    LogUtils.showPrint('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    LogUtils.showPrint('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    LogUtils.showPrint('dispose');
    super.dispose();
  }

  ///初始化数据
  void initData() {
    indexStack = new IndexedStack(
      children: <Widget>[
        new HomePage(),
        new FindPage(),
        new TodoPage(),
        new MePage()
      ],
      index: positionIndex,
    );
  }

  ///设置appBar
  AppBar initAppBar() {
    return new AppBar(
      title: new Text(
        mainTitles[positionIndex],
        style: new TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        new IconButton(
            icon: new Icon(Icons.account_balance),
            onPressed: () {
              navigatorKey.currentState
                  .push(new MaterialPageRoute(builder: (context) {
                return null;
              }));
            }),
        new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {
              navigatorKey.currentState
                  .push(new MaterialPageRoute(builder: (context) {
                return new SearchPage(null);
              }));
            }),
        new IconButton(
            icon: new Icon(Icons.settings),
            onPressed: () {
              LogUtils.showPrint("点击设置按钮，跳转设置中心");
              //不要用下面这个，这个点击事件会报错
              //报错日志：Another exception was thrown: Navigator operation requested with a context that does not include a Navigator.
              //后期在研究原理
              /*Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                      return new SettingPage();
                    }));*/
              navigatorKey.currentState
                  .push(new MaterialPageRoute(builder: (context) {
                return new SettingPage();
              }));
            })
      ],
    );
  }

  ///初始化侧滑菜单控件
  SmartDrawer initDrawer() {
    return new SmartDrawer(
      widthPercent: 0.7,
      elevation: 0,
      child: new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text('測試'),
            accountEmail: Text('hfshjfsdhf@163.com'),
            onDetailsPressed: () {
              navigatorKey.currentState
                  .push(new MaterialPageRoute(builder: (context) {
                return new AboutMePage();
              }));
            },
            currentAccountPicture: new GestureDetector(
              child: new CircleAvatar(
                backgroundImage: new ExactAssetImage('ic_person.jpg'),
              ),
              onTap: () {
                navigatorKey.currentState
                    .push(new MaterialPageRoute(builder: (context) {
                  return new AboutMePage();
                }));
              },
            ),
          ),
          new ListTile(
              title: new Text('我的收藏'),
              trailing: new Icon(Icons.email),
              onTap: () {}),
          new Divider(),
          new ListTile(
            title: Text('消息中心'),
            trailing: new Icon(Icons.verified_user),
            onTap: () {},
          ),
          new Divider(),
          new ListTile(
              title: new Text("设置中心"),
              trailing: new Icon(Icons.settings),
              onTap: () {
                LogUtils.showPrint("设置中心");
                /*Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                  return new SettingPage();
                }));*/
                //关闭侧滑菜单
                navigatorKey.currentState
                    .push(new MaterialPageRoute(builder: (context) {
                  return new SettingPage();
                }));
                //模拟发送通知
                EventBus.internal().on(Constants.busSetting, (arg) {
                  // do something
                  LogUtils.showPrint("发送消息通知，设置");
                });
              }),
          new Divider(),
        ],
      ),
    );
  }

  //底部导航栏
  BottomNavigationBar initNavigationBar() {
    return new BottomNavigationBar(
      items: navigationViews
          .map((BottomNavigationBarItem navigationView) => navigationView)
          .toList(),
      currentIndex: positionIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          positionIndex = index;
        });
      },
    );
  }

  void initNavigationBarView() {
    navigationViews = <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        title: new Text(mainTitles[0]),
        backgroundColor: Colors.black,
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.assignment),
        title: new Text(mainTitles[1]),
        backgroundColor: Colors.black,
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.devices_other),
        title: new Text(mainTitles[2]),
        backgroundColor: Colors.black,
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        title: new Text(mainTitles[3]),
        backgroundColor: Colors.black,
      ),
    ];
  }
}
