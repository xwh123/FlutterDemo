import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/Api.dart';
import 'package:flutter_demo/entity/UserEntity.dart';
import 'package:flutter_demo/page/MyHomePage.dart';
import 'package:flutter_demo/utils/HttpUtil.dart';
import 'package:flutter_demo/widget/LoadingDialog.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:toast/toast.dart';

/**
 * @desc: 登录界面
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2019/12/19 0019 18:20
 * @UpdateUser： 更新者
 * @UpdateDate:     2019/12/19 0019 18:20
 * @UpdateRemark:   更新说明
 * @version:
 */
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  //默认创建 Key 将会通过工厂方法根据传入的 value 创建一个 ValueKey。
  //Key 派生出两种不同用途的 Key：LocalKey 和 GlobalKey。
  // GlobalKey 能够跨 Widget 访问状态。 在这里我们有一个 Switcher 小部件，它可以通过 changeState 改变它的状态。
  GlobalKey<FormState> _formKey = GlobalKey();

  //是否正在显示加载
  bool _loadingProgess = false;

  String _phoneNumber, _passWord, _confirmPassWord;

  //是否是密码
  bool _isObscure = true;

  //是否注册
  bool _confirmVisibleRegist = true;

  //眼睛的颜色
  Color _eyeColor;

  String btnText = "登录";
  String bottomText = "没有账号？";
  String logingRegistText = "点击注册";
  String titleText = "Login";

  //如果为true，则表单字段将验证并更新其错误文本
  // 每一次改变之后。否则，你必须打电话
  // [FormState.validate]进行验证。
  bool autoValidate = false;

  List _loginMethod = [
    {
      "title": "QQ",
      "icon": GroovinMaterialIcons.qqchat,
    },
    {
      "title": "微信",
      "icon": GroovinMaterialIcons.wechat,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidate: autoValidate,
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          //EdgeInsets.symmetric 创建具有对称垂直和水平偏移的插入。
          children: <Widget>[
            //SizedBox 创建固定大小的框。[宽度]和[高度]参数可以为空
            // 指示框的大小不应限制在相应的维度。
            SizedBox(
              height: kToolbarHeight,
            ),
            buildTitle(),
//            buildTitleLine(),
            SizedBox(height: 5.0),
            buildPhoneNumberTextField(),
            SizedBox(height: 30.0),
            buildPasswordTextField(context),
            SizedBox(height: 30.0),
            Offstage(
              //offstage:是否显示  true：隐藏 false:显示
              offstage: _confirmVisibleRegist,
              child: Column(
                children: <Widget>[
                  buildConfirmPasswordTextField(context),
                ],
              ),
            ),
            buildForgetPasswordText(context),
            SizedBox(height: 35.0),
            buildLoginButton(context),
            SizedBox(height: 30.0),
            buildOtherLoginText(),
            buildOtherMethod(context),
            buildRegisterText(context),
          ],
        ),
      ),
    );
  }

  /**
   * 确认密码
   */
  TextFormField buildConfirmPasswordTextField(BuildContext context) {
    return TextFormField(
      //是否密码
      obscureText: _isObscure,
      validator:_confirmVisibleRegist?null:validateRePassword ,
      //InputDecoration 对输入文本的校验
      decoration: InputDecoration(
        labelText: '确认密码',
        suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: _eyeColor,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
              _eyeColor =
                  _isObscure ? Colors.grey : Theme.of(context).iconTheme.color;
            });
          },
        ),
      ),
      //保存
      onSaved: (String value) => _confirmPassWord,
    );
  }

  String validateRePassword(String registPassword) {
    if (registPassword.isEmpty) return '确认密码不能为空';
    if (registPassword.length < 6) return '确认密码长度不能小于6位';
  }

  /**
   * 生成注册输入框
   */
  Align buildRegisterText(BuildContext context) {
    //居中 在其他端的开发，Align一般都是当做一个控件的属性，并没有拿出来当做一个单独的控件。
    // Align本身实现的功能并不复杂，设置child的对齐方式，例如居中、居左居右等，并根据child尺寸调节自身尺寸。
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 5.0), //EdgeInsets.only 创建只有给定值非零的插入
        child: Row(
          //MainAxisAlignment（主轴）就是与当前控件方向一致的轴,在水平方向控件中，例如Row
          //MainAxisAlignment是水平的，默认起始位置在左边，排列方向为从左至右，
          // 此时可以通过textDirection来改变MainAxisAlignment的起始位置和排列方向
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(bottomText),
            //GestureDetector 是检测手势的widget。如果GestureDetector 的child属性不空，GestureDetector将自己大小设置为child的大小。
            // 如果child属性为空，它将自己的大小设置为父组件的大小。（稍后通过代码测试一下）.
            GestureDetector(
              child: Text(
                logingRegistText,
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                setState(() {
                  if (_confirmVisibleRegist) {
                    //点击事件  注册/登录
                    bottomText = '已有帐号？';
                    titleText = "Regist";
                    logingRegistText = '点击登录';
                    btnText = '注册';
                  } else {
                    btnText = '登录';
                    bottomText = '没有帐号？';
                    titleText = "Login";
                    logingRegistText = '点击注册';
                  }
                  _confirmVisibleRegist = !_confirmVisibleRegist;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  //第三方登录
  ButtonBar buildOtherMethod(BuildContext context) {
    return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: _loginMethod
            .map((item) => Builder(
                  builder: (context) {
                    return IconButton(
                      icon: Icon(item['icon'],
                          color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        //第三方登录
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text('${item['title']}登录'),
                          action: new SnackBarAction(
                            label: '取消',
                            onPressed: () {},
                          ),
                        ));
                      },
                    );
                  },
                ))
            .toList());
  }

  //其他账号登陆
  Align buildOtherLoginText() {
    return Align(
        alignment: Alignment.center,
        child: Text(
          '其他账号登录',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ));
  }

  //登录按钮
  Align buildLoginButton(BuildContext context) {
    return Align(
      //SizedBox 创建固定大小的框。[宽度]和[高度]参数可以为空
      // 指示框的大小不应限制在相应的维度。
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        //RaisedButton:凸起的按钮，其实就是Android中的Material Design风格的Button ，继承自MaterialButton
        child: RaisedButton(
          child: Text(btnText),
          color: Colors.amber,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              //只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
              // 调用登录方法
//              countDown();
              registLogin();
            } else {
              setState(() {
                autoValidate = true;
              });
            }
          },
          //边框
          shape: StadiumBorder(side: BorderSide(color: Colors.red)),
        ),
      ),
    );
  }

  //忘记密码
  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      //在其他端的开发，Align一般都是当做一个控件的属性，并没有拿出来当做一个单独的控件。
      // Align本身实现的功能并不复杂，设置child的对齐方式，例如居中、居左居右等，并根据child尺寸调节自身尺寸。
      child: Align(
        alignment: Alignment.centerRight,
        //扁平化的按钮，继承自MaterialButton
        child: FlatButton(
            onPressed: () {
              Toast.show("点击了忘记密码", context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            },
            child: Text(
              '忘记密码？',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            )),
      ),
    );
  }

  //密码输入框
  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      //保存
      onSaved: (String value) => _passWord = value,
      //是否是密码
      obscureText: _isObscure,
      //验证
      validator: (String value) {
        if (value.isEmpty) {
          return '密码不能为空';
        }
        if (value.length < 6) {
          return '密码长度不能小于6位';
        }
      },
      //InputDecoration 对输入文本的校验
      decoration: InputDecoration(
          labelText: '密码',
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: _eyeColor,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
                _eyeColor = _isObscure
                    ? Colors.grey
                    : Theme.of(context).iconTheme.color;
              });
            },
          )),
    );
  }

  //电话号码
  TextFormField buildPhoneNumberTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '手机号码',
      ),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        //验证手机号码的正则
        var phoneReg = RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$');
        if (!phoneReg.hasMatch(value)) {
          return '请输入正确的手机号码';
        }
      },
      //保存
      onSaved: (text) {
        setState(() {
          _phoneNumber = text;
        });
      },
    );
  }

  //title的下划线
  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: new Center(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            color: Colors.black,
            width: 40.0,
            height: 2.0,
          ),
        ),
      ),
    );
  }

  /**
   * title
   */
  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: new Center(
        child: new Text(
          titleText,
          style: TextStyle(fontSize: 40.0, color: Colors.blue),
        ),
      ),
    );
  }

  Future registLogin() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: "账号登录中…",
          );
        });

    var data;
    if (_confirmVisibleRegist) {
      data = {'username': _phoneNumber, 'password': _passWord};
    } else {
      data = {
        'username': _phoneNumber,
        'password': _passWord,
        'repassword': _passWord
      };
    }

    var response = await HttpUtil()
        .post(_confirmVisibleRegist ? Api.LOGIN : Api.REGISTER, data: data);

    Map userMap = json.decode(response.toString());
    var userEntity = UserEntity.fromJson(userMap);
    Navigator.pop(context);
    if (0 == userEntity.errorCode) {
      Toast.show(_confirmVisibleRegist ? "登录成功" : "注册成功", context,
          duration: Toast.LENGTH_SHORT);
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => new MyHomePage()),
          (Route<dynamic> rout) => false);
    } else {
      Toast.show(userEntity.errorMsg, context, duration: Toast.LENGTH_SHORT);
    }
  }

  void countDown() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: "账号登录中…",
          );
        });

    //设置倒计时三秒后执行跳转方法
    var duration = new Duration(seconds: 3);
    new Future.delayed(duration, () {
      setState(() {
        _loadingProgess = !_loadingProgess;
        Toast.show("登录成功", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        Navigator.pop(context);
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => new MyHomePage()),
            (Route<dynamic> rout) => false);
      });
    });
  }
}
