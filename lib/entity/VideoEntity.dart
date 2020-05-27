/**
 * @desc: 作用描述
 * @projectName:flutter_demo
 * @author:xuwh
 * @date:2020/1/9 0009 22:14
 * @UpdateUser： 更新者
 * @UpdateDate:     2020/1/9 0009 22:14
 * @UpdateRemark:   更新说明
 * @version:
 */

class VideoEntity {
  List<VideoResult> result;
  int code;
  String message;

  VideoEntity({this.result, this.code, this.message});

  VideoEntity.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<VideoResult>();(json['result'] as List).forEach((v) { result.add(new VideoResult.fromJson(v)); });
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] =  this.result.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class VideoResult {
  VideoResultData data;
  int adIndex;
  dynamic tag;
  int id;
  String type;

  VideoResult({this.data, this.adIndex, this.tag, this.id, this.type});

  VideoResult.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new VideoResultData.fromJson(json['data']) : null;
    adIndex = json['adIndex'];
    tag = json['tag'];
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['adIndex'] = this.adIndex;
    data['tag'] = this.tag;
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}

class VideoResultData {
  String dataType;
  VideoResultDataHeader header;
  VideoResultDataContent content;
  List<Null> adTrack;

  VideoResultData({this.dataType, this.header, this.content, this.adTrack});

  VideoResultData.fromJson(Map<String, dynamic> json) {
    dataType = json['dataType'];
    header = json['header'] != null ? new VideoResultDataHeader.fromJson(json['header']) : null;
    content = json['content'] != null ? new VideoResultDataContent.fromJson(json['content']) : null;
    if (json['adTrack'] != null) {
      adTrack = new List<Null>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataType'] = this.dataType;
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    if (this.adTrack != null) {
      data['adTrack'] =  [];
    }
    return data;
  }
}

class VideoResultDataHeader {
  String textAlign;
  dynamic subTitleFont;
  String actionUrl;
  String icon;
  String description;
  bool showHateVideo;
  dynamic label;
  String title;
  dynamic cover;
  dynamic rightText;
  dynamic labelList;
  dynamic subTitle;
  String iconType;
  int id;
  int time;
  dynamic font;

  VideoResultDataHeader({this.textAlign, this.subTitleFont, this.actionUrl, this.icon, this.description, this.showHateVideo, this.label, this.title, this.cover, this.rightText, this.labelList, this.subTitle, this.iconType, this.id, this.time, this.font});

  VideoResultDataHeader.fromJson(Map<String, dynamic> json) {
    textAlign = json['textAlign'];
    subTitleFont = json['subTitleFont'];
    actionUrl = json['actionUrl'];
    icon = json['icon'];
    description = json['description'];
    showHateVideo = json['showHateVideo'];
    label = json['label'];
    title = json['title'];
    cover = json['cover'];
    rightText = json['rightText'];
    labelList = json['labelList'];
    subTitle = json['subTitle'];
    iconType = json['iconType'];
    id = json['id'];
    time = json['time'];
    font = json['font'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['textAlign'] = this.textAlign;
    data['subTitleFont'] = this.subTitleFont;
    data['actionUrl'] = this.actionUrl;
    data['icon'] = this.icon;
    data['description'] = this.description;
    data['showHateVideo'] = this.showHateVideo;
    data['label'] = this.label;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['rightText'] = this.rightText;
    data['labelList'] = this.labelList;
    data['subTitle'] = this.subTitle;
    data['iconType'] = this.iconType;
    data['id'] = this.id;
    data['time'] = this.time;
    data['font'] = this.font;
    return data;
  }
}

class VideoResultDataContent {
  VideoResultDataContentData data;
  int adIndex;
  dynamic tag;
  int id;
  String type;

  VideoResultDataContent({this.data, this.adIndex, this.tag, this.id, this.type});

  VideoResultDataContent.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new VideoResultDataContentData.fromJson(json['data']) : null;
    adIndex = json['adIndex'];
    tag = json['tag'];
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['adIndex'] = this.adIndex;
    data['tag'] = this.tag;
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}

class VideoResultDataContentData {
  int date;
  dynamic shareAdTrack;
  int releaseTime;
  dynamic brandWebsiteInfo;
  String description;
  String remark;
  bool collected;
  String title;
  String type;
  dynamic favoriteAdTrack;
  dynamic waterMarks;
  String playUrl;
  VideoResultDataContentDataCover cover;
  int duration;
  String xLibrary;
  String descriptionEditor;
  VideoResultDataContentDataProvider provider;
  int id;
  String descriptionPgc;
  String titlePgc;
  List<Null> adTrack;
  List<Null> subtitles;
  bool ad;
  dynamic src;
  VideoResultDataContentDataAuthor author;
  String dataType;
  int searchWeight;
  dynamic playlists;
  VideoResultDataContentDataConsumption consumption;
  bool reallyCollected;
  dynamic label;
  bool played;
  List<VideoResultDataContentDataTag> tags;
  dynamic webAdTrack;
  List<Null> labelList;
  dynamic lastViewTime;
  List<Null> playInfo;
  bool ifLimitVideo;
  VideoResultDataContentDataWeburl webUrl;
  dynamic campaign;
  String category;
  int idx;
  dynamic slogan;
  dynamic thumbPlayUrl;
  String resourceType;
  dynamic promotion;

  VideoResultDataContentData({this.date, this.shareAdTrack, this.releaseTime, this.brandWebsiteInfo, this.description, this.remark, this.collected, this.title, this.type, this.favoriteAdTrack, this.waterMarks, this.playUrl, this.cover, this.duration, this.xLibrary, this.descriptionEditor, this.provider, this.id, this.descriptionPgc, this.titlePgc, this.adTrack, this.subtitles, this.ad, this.src, this.author, this.dataType, this.searchWeight, this.playlists, this.consumption, this.reallyCollected, this.label, this.played, this.tags, this.webAdTrack, this.labelList, this.lastViewTime, this.playInfo, this.ifLimitVideo, this.webUrl, this.campaign, this.category, this.idx, this.slogan, this.thumbPlayUrl, this.resourceType, this.promotion});

  VideoResultDataContentData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    shareAdTrack = json['shareAdTrack'];
    releaseTime = json['releaseTime'];
    brandWebsiteInfo = json['brandWebsiteInfo'];
    description = json['description'];
    remark = json['remark'];
    collected = json['collected'];
    title = json['title'];
    type = json['type'];
    favoriteAdTrack = json['favoriteAdTrack'];
    waterMarks = json['waterMarks'];
    playUrl = json['playUrl'];
    cover = json['cover'] != null ? new VideoResultDataContentDataCover.fromJson(json['cover']) : null;
    duration = json['duration'];
    xLibrary = json['library'];
    descriptionEditor = json['descriptionEditor'];
    provider = json['provider'] != null ? new VideoResultDataContentDataProvider.fromJson(json['provider']) : null;
    id = json['id'];
    descriptionPgc = json['descriptionPgc'];
    titlePgc = json['titlePgc'];
    if (json['adTrack'] != null) {
      adTrack = new List<Null>();
    }
    if (json['subtitles'] != null) {
      subtitles = new List<Null>();
    }
    ad = json['ad'];
    src = json['src'];
    author = json['author'] != null ? new VideoResultDataContentDataAuthor.fromJson(json['author']) : null;
    dataType = json['dataType'];
    searchWeight = json['searchWeight'];
    playlists = json['playlists'];
    consumption = json['consumption'] != null ? new VideoResultDataContentDataConsumption.fromJson(json['consumption']) : null;
    reallyCollected = json['reallyCollected'];
    label = json['label'];
    played = json['played'];
    if (json['tags'] != null) {
      tags = new List<VideoResultDataContentDataTag>();(json['tags'] as List).forEach((v) { tags.add(new VideoResultDataContentDataTag.fromJson(v)); });
    }
    webAdTrack = json['webAdTrack'];
    if (json['labelList'] != null) {
      labelList = new List<Null>();
    }
    lastViewTime = json['lastViewTime'];
    if (json['playInfo'] != null) {
      playInfo = new List<Null>();
    }
    ifLimitVideo = json['ifLimitVideo'];
    webUrl = json['webUrl'] != null ? new VideoResultDataContentDataWeburl.fromJson(json['webUrl']) : null;
    campaign = json['campaign'];
    category = json['category'];
    idx = json['idx'];
    slogan = json['slogan'];
    thumbPlayUrl = json['thumbPlayUrl'];
    resourceType = json['resourceType'];
    promotion = json['promotion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['shareAdTrack'] = this.shareAdTrack;
    data['releaseTime'] = this.releaseTime;
    data['brandWebsiteInfo'] = this.brandWebsiteInfo;
    data['description'] = this.description;
    data['remark'] = this.remark;
    data['collected'] = this.collected;
    data['title'] = this.title;
    data['type'] = this.type;
    data['favoriteAdTrack'] = this.favoriteAdTrack;
    data['waterMarks'] = this.waterMarks;
    data['playUrl'] = this.playUrl;
    if (this.cover != null) {
      data['cover'] = this.cover.toJson();
    }
    data['duration'] = this.duration;
    data['library'] = this.xLibrary;
    data['descriptionEditor'] = this.descriptionEditor;
    if (this.provider != null) {
      data['provider'] = this.provider.toJson();
    }
    data['id'] = this.id;
    data['descriptionPgc'] = this.descriptionPgc;
    data['titlePgc'] = this.titlePgc;
    if (this.adTrack != null) {
      data['adTrack'] =  [];
    }
    if (this.subtitles != null) {
      data['subtitles'] =  [];
    }
    data['ad'] = this.ad;
    data['src'] = this.src;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['dataType'] = this.dataType;
    data['searchWeight'] = this.searchWeight;
    data['playlists'] = this.playlists;
    if (this.consumption != null) {
      data['consumption'] = this.consumption.toJson();
    }
    data['reallyCollected'] = this.reallyCollected;
    data['label'] = this.label;
    data['played'] = this.played;
    if (this.tags != null) {
      data['tags'] =  this.tags.map((v) => v.toJson()).toList();
    }
    data['webAdTrack'] = this.webAdTrack;
    if (this.labelList != null) {
      data['labelList'] =  [];
    }
    data['lastViewTime'] = this.lastViewTime;
    if (this.playInfo != null) {
      data['playInfo'] =  [];
    }
    data['ifLimitVideo'] = this.ifLimitVideo;
    if (this.webUrl != null) {
      data['webUrl'] = this.webUrl.toJson();
    }
    data['campaign'] = this.campaign;
    data['category'] = this.category;
    data['idx'] = this.idx;
    data['slogan'] = this.slogan;
    data['thumbPlayUrl'] = this.thumbPlayUrl;
    data['resourceType'] = this.resourceType;
    data['promotion'] = this.promotion;
    return data;
  }
}

class VideoResultDataContentDataCover {
  String feed;
  String detail;
  dynamic sharing;
  String blurred;
  dynamic homepage;

  VideoResultDataContentDataCover({this.feed, this.detail, this.sharing, this.blurred, this.homepage});

  VideoResultDataContentDataCover.fromJson(Map<String, dynamic> json) {
    feed = json['feed'];
    detail = json['detail'];
    sharing = json['sharing'];
    blurred = json['blurred'];
    homepage = json['homepage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feed'] = this.feed;
    data['detail'] = this.detail;
    data['sharing'] = this.sharing;
    data['blurred'] = this.blurred;
    data['homepage'] = this.homepage;
    return data;
  }
}

class VideoResultDataContentDataProvider {
  String name;
  String icon;
  String alias;

  VideoResultDataContentDataProvider({this.name, this.icon, this.alias});

  VideoResultDataContentDataProvider.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    alias = json['alias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['alias'] = this.alias;
    return data;
  }
}

class VideoResultDataContentDataAuthor {
  VideoResultDataContentDataAuthorShield shield;
  bool expert;
  int approvedNotReadyVideoCount;
  String icon;
  String link;
  String description;
  int videoNum;
  VideoResultDataContentDataAuthorFollow follow;
  int recSort;
  String name;
  bool ifPgc;
  int latestReleaseTime;
  int id;
  dynamic adTrack;

  VideoResultDataContentDataAuthor({this.shield, this.expert, this.approvedNotReadyVideoCount, this.icon, this.link, this.description, this.videoNum, this.follow, this.recSort, this.name, this.ifPgc, this.latestReleaseTime, this.id, this.adTrack});

  VideoResultDataContentDataAuthor.fromJson(Map<String, dynamic> json) {
    shield = json['shield'] != null ? new VideoResultDataContentDataAuthorShield.fromJson(json['shield']) : null;
    expert = json['expert'];
    approvedNotReadyVideoCount = json['approvedNotReadyVideoCount'];
    icon = json['icon'];
    link = json['link'];
    description = json['description'];
    videoNum = json['videoNum'];
    follow = json['follow'] != null ? new VideoResultDataContentDataAuthorFollow.fromJson(json['follow']) : null;
    recSort = json['recSort'];
    name = json['name'];
    ifPgc = json['ifPgc'];
    latestReleaseTime = json['latestReleaseTime'];
    id = json['id'];
    adTrack = json['adTrack'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shield != null) {
      data['shield'] = this.shield.toJson();
    }
    data['expert'] = this.expert;
    data['approvedNotReadyVideoCount'] = this.approvedNotReadyVideoCount;
    data['icon'] = this.icon;
    data['link'] = this.link;
    data['description'] = this.description;
    data['videoNum'] = this.videoNum;
    if (this.follow != null) {
      data['follow'] = this.follow.toJson();
    }
    data['recSort'] = this.recSort;
    data['name'] = this.name;
    data['ifPgc'] = this.ifPgc;
    data['latestReleaseTime'] = this.latestReleaseTime;
    data['id'] = this.id;
    data['adTrack'] = this.adTrack;
    return data;
  }
}

class VideoResultDataContentDataAuthorShield {
  int itemId;
  String itemType;
  bool shielded;

  VideoResultDataContentDataAuthorShield({this.itemId, this.itemType, this.shielded});

  VideoResultDataContentDataAuthorShield.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemType = json['itemType'];
    shielded = json['shielded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['itemType'] = this.itemType;
    data['shielded'] = this.shielded;
    return data;
  }
}

class VideoResultDataContentDataAuthorFollow {
  int itemId;
  String itemType;
  bool followed;

  VideoResultDataContentDataAuthorFollow({this.itemId, this.itemType, this.followed});

  VideoResultDataContentDataAuthorFollow.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemType = json['itemType'];
    followed = json['followed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['itemType'] = this.itemType;
    data['followed'] = this.followed;
    return data;
  }
}

class VideoResultDataContentDataConsumption {
  int shareCount;
  int replyCount;
  int realCollectionCount;
  int collectionCount;

  VideoResultDataContentDataConsumption({this.shareCount, this.replyCount, this.realCollectionCount, this.collectionCount});

  VideoResultDataContentDataConsumption.fromJson(Map<String, dynamic> json) {
    shareCount = json['shareCount'];
    replyCount = json['replyCount'];
    realCollectionCount = json['realCollectionCount'];
    collectionCount = json['collectionCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shareCount'] = this.shareCount;
    data['replyCount'] = this.replyCount;
    data['realCollectionCount'] = this.realCollectionCount;
    data['collectionCount'] = this.collectionCount;
    return data;
  }
}

class VideoResultDataContentDataTag {
  String actionUrl;
  dynamic childTagList;
  String bgPicture;
  bool haveReward;
  dynamic childTagIdList;
  String tagRecType;
  bool ifNewest;
  String headerImage;
  String name;
  int communityIndex;
  int id;
  dynamic adTrack;
  String desc;
  dynamic newestEndTime;

  VideoResultDataContentDataTag({this.actionUrl, this.childTagList, this.bgPicture, this.haveReward, this.childTagIdList, this.tagRecType, this.ifNewest, this.headerImage, this.name, this.communityIndex, this.id, this.adTrack, this.desc, this.newestEndTime});

  VideoResultDataContentDataTag.fromJson(Map<String, dynamic> json) {
    actionUrl = json['actionUrl'];
    childTagList = json['childTagList'];
    bgPicture = json['bgPicture'];
    haveReward = json['haveReward'];
    childTagIdList = json['childTagIdList'];
    tagRecType = json['tagRecType'];
    ifNewest = json['ifNewest'];
    headerImage = json['headerImage'];
    name = json['name'];
    communityIndex = json['communityIndex'];
    id = json['id'];
    adTrack = json['adTrack'];
    desc = json['desc'];
    newestEndTime = json['newestEndTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actionUrl'] = this.actionUrl;
    data['childTagList'] = this.childTagList;
    data['bgPicture'] = this.bgPicture;
    data['haveReward'] = this.haveReward;
    data['childTagIdList'] = this.childTagIdList;
    data['tagRecType'] = this.tagRecType;
    data['ifNewest'] = this.ifNewest;
    data['headerImage'] = this.headerImage;
    data['name'] = this.name;
    data['communityIndex'] = this.communityIndex;
    data['id'] = this.id;
    data['adTrack'] = this.adTrack;
    data['desc'] = this.desc;
    data['newestEndTime'] = this.newestEndTime;
    return data;
  }
}

class VideoResultDataContentDataWeburl {
  String forWeibo;
  String raw;

  VideoResultDataContentDataWeburl({this.forWeibo, this.raw});

  VideoResultDataContentDataWeburl.fromJson(Map<String, dynamic> json) {
    forWeibo = json['forWeibo'];
    raw = json['raw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['forWeibo'] = this.forWeibo;
    data['raw'] = this.raw;
    return data;
  }
}

