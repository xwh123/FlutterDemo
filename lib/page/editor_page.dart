import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

/**
 * @desc: 富文本编辑器界面
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2020/2/1 0001 17:02
 * @UpdateUser： 更新者
 * @UpdateDate:     2020/2/1 0001 17:02
 * @UpdateRemark:   更新说明
 * @version:
 */
class EditorPage extends StatefulWidget {
  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  //编辑器控制器
  ZefyrController _controller;

  //Zefyr编辑器与任何其他输入字段一样，需要一个焦点节点。
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    //在这里，我们必须加载文档并将其传递给Zefyr控制器。
    final document = _loadDocument();
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('编辑器')),
      body: ZefyrScaffold(
        child: ZefyrEditor(
          controller: _controller,
          focusNode: _focusNode,
          padding: EdgeInsets.all(16),
        ),
      ),
    );
  }

  /**
   * 加载要在Zefyr中编辑的文档。
   */
  NotusDocument _loadDocument() {
    //为了简单起见，我们用一行文本硬编码一个简单的文档
    //Zefyr快速启动
    //注意delta必须始终以换行符结尾。
    final Delta delta = Delta()..insert("开始编辑吧\n");
    return NotusDocument.fromDelta(delta);
  }
}
