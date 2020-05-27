import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/page/SplashPage.dart';

import 'page/MyHomePage.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        //去除右上角debug标签
        routes: <String, WidgetBuilder>{
          '/HomePage': (BuildContext context) => new MyHomePage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new SplashPage()
    );
  }
}
