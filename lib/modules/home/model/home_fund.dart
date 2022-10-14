

class HomeFund {
  int? code;
  String? msg;
  FundData? data;
  int? serverTime;

  HomeFund({this.code, this.msg, this.data, this.serverTime});

  HomeFund.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new FundData.fromJson(json['data']) : null;
    serverTime = json['serverTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['serverTime'] = this.serverTime;
    return data;
  }
}

class FundData {
  List<FundList>? fundList;
  String? h5Url;

  FundData({this.fundList, this.h5Url});

  FundData.fromJson(Map<String, dynamic> json) {
    if (json['fundList'] != null) {
      fundList = <FundList>[];
      json['fundList'].forEach((v) {
        fundList!.add(new FundList.fromJson(v));
      });
    }
    h5Url = json['h5Url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fundList != null) {
      data['fundList'] = this.fundList!.map((v) => v.toJson()).toList();
    }
    data['h5Url'] = this.h5Url;
    return data;
  }
}

class FundList {
  String? name;
  String? intro;
  int? profitType;
  String? profitTypeDes;
  String? profitRate;
  List<int>? tagIdArr;
  List<String>? tagArr;
  int? sort;
  String? surfaceImg;
  String? url;
  int? status;
  int? indexShow;
  int? createdAt;
  bool? canVisit;
  String? noAccessLink;
  int? type;
  String? minimumAmount;
  String? suggestTime;
  List<AssetRadio>? assetRadio;
  List<Null>? objectDetail;
  String? enterLevelArr;
  String? buttonDes;

  FundList(
      {this.name,
        this.intro,
        this.profitType,
        this.profitTypeDes,
        this.profitRate,
        this.tagIdArr,
        this.tagArr,
        this.sort,
        this.surfaceImg,
        this.url,
        this.status,
        this.indexShow,
        this.createdAt,
        this.canVisit,
        this.noAccessLink,
        this.type,
        this.minimumAmount,
        this.suggestTime,
        this.assetRadio,
        this.objectDetail,
        this.enterLevelArr,
        this.buttonDes});

  FundList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    intro = json['intro'];
    profitType = json['profitType'];
    profitTypeDes = json['profitTypeDes'];
    profitRate = json['profitRate'];
    tagIdArr = json['tagIdArr'].cast<int>();
    tagArr = json['tagArr'].cast<String>();
    sort = json['sort'];
    surfaceImg = json['surfaceImg'];
    url = json['url'];
    status = json['status'];
    indexShow = json['indexShow'];
    createdAt = json['createdAt'];
    canVisit = json['canVisit'];
    noAccessLink = json['noAccessLink'];
    type = json['type'];
    minimumAmount = json['minimumAmount'];
    suggestTime = json['suggestTime'];
    if (json['assetRadio'] != null) {
      assetRadio = <AssetRadio>[];
      json['assetRadio'].forEach((v) {
        assetRadio!.add(new AssetRadio.fromJson(v));
      });
    }
    if (json['objectDetail'] != null) {
      objectDetail = <Null>[];
      json['objectDetail'].forEach((v) {
        // objectDetail!.add(new Null.fromJson(v));
      });
    }
    enterLevelArr = json['enterLevelArr'];
    buttonDes = json['buttonDes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['intro'] = this.intro;
    data['profitType'] = this.profitType;
    data['profitTypeDes'] = this.profitTypeDes;
    data['profitRate'] = this.profitRate;
    data['tagIdArr'] = this.tagIdArr;
    data['tagArr'] = this.tagArr;
    data['sort'] = this.sort;
    data['surfaceImg'] = this.surfaceImg;
    data['url'] = this.url;
    data['status'] = this.status;
    data['indexShow'] = this.indexShow;
    data['createdAt'] = this.createdAt;
    data['canVisit'] = this.canVisit;
    data['noAccessLink'] = this.noAccessLink;
    data['type'] = this.type;
    data['minimumAmount'] = this.minimumAmount;
    data['suggestTime'] = this.suggestTime;
    if (this.assetRadio != null) {
      data['assetRadio'] = this.assetRadio!.map((v) => v.toJson()).toList();
    }
    if (this.objectDetail != null) {
      // data['objectDetail'] = this.objectDetail!.map((v) => v.toJson()).toList();
    }
    data['enterLevelArr'] = this.enterLevelArr;
    data['buttonDes'] = this.buttonDes;
    return data;
  }
}

class AssetRadio {
  String? assetName;
  num? radio;
  String? color;
  int? status;
  AssetRadio({this.assetName, this.radio, this.color});

  AssetRadio.fromJson(Map<String, dynamic> json) {
    assetName = json['assetName'];
    radio = json['radio'] ?? 0;
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assetName'] = this.assetName;
    data['radio'] = this.radio;
    data['color'] = this.color;
    return data;
  }
}