import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

/**
 * @desc: 视频播放界面
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2020/1/10 0010 15:18
 * @UpdateUser： 更新者
 * @UpdateDate:     2020/1/10 0010 15:18
 * @UpdateRemark:   更新说明
 * @version:
 */
class VideoPlayPage extends StatefulWidget {
  final videoUrl;
  final title;

  VideoPlayPage({Key key, this.videoUrl, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _VideoPlayPageState();
  }
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  FijkPlayer _fijkPlayer = FijkPlayer();

  double _vHeight = 200;

  @override
  void initState() {
    super.initState();
    _fijkPlayer.setDataSource('${widget.videoUrl}', autoPlay: true);
    _fijkPlayer.addListener(_fijkValueListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.videoUrl}'),
      ),
      body: Container(
        height: _vHeight,
        child: FijkVolumeWatcher(
            watcher: null,
            showToast: true,
            child: FijkView(
              player: _fijkPlayer,height: _vHeight,width: MediaQuery.of(context).size.width,fit: FijkFit.fill,
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //释放资源
    _fijkPlayer.release();
    _fijkPlayer.removeListener(_fijkValueListener);
  }

  //播放器监听器
  void _fijkValueListener() {
    FijkValue _fijkValue = _fijkPlayer.value;


    if (_fijkValue.completed) {
      Toast.show('播放完成', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }
}
