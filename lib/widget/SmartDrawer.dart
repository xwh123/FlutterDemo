import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


/**
 * @desc: 自定义侧滑控件，主要是为了限制宽度
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2019/12/18 0018 15:50
 * @UpdateUser： 更新者
 * @UpdateDate:     2019/12/18 0018 15:50
 * @UpdateRemark:   更新说明
 * @version:
 */
class SmartDrawer extends StatelessWidget {
  final double elevation;
  final Widget child;
  final String semanticLabel;
  final double widthPercent;

  SmartDrawer(
      {Key key,
      this.elevation,
      this.child,
      this.semanticLabel,
      this.widthPercent})
      : assert(
            widthPercent != null && widthPercent < 1.0 && widthPercent > 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String label = semanticLabel;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        label = semanticLabel;
        break;
      case TargetPlatform.android:
        break;
      case TargetPlatform.fuchsia:
        label = semanticLabel ?? MaterialLocalizations.of(context)?.drawerLabel;
        break;
    }
    final double _width = MediaQuery.of(context).size.width * widthPercent;

    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(width: _width),
        child: Material(
          elevation: elevation,
          child: child,
        ),
      ),
    );
  }
}
