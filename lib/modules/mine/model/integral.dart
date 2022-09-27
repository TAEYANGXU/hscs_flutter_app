class IntegralData {
  int? goodId;
  String? name;
  String? goodsImg;
  int? price;
  int? goodsType;
  String? goodsNumber;
  String? h5Link;
  String? appLink;
  int? sort;
  int? goodsDuration;
  String? goodsDesc;
  String? goodsIntroduction;
  String? canBuyUserLevel;
  List<CanBuyUserLevelArr>? canBuyUserLevelArr;
  String? couponsId;
  String? giftCardId;
  int? limitAmount;
  String? limitToast;
  int? exchangedAmount;

  IntegralData(
      {this.goodId,
        this.name,
        this.goodsImg,
        this.price,
        this.goodsType,
        this.goodsNumber,
        this.h5Link,
        this.appLink,
        this.sort,
        this.goodsDuration,
        this.goodsDesc,
        this.goodsIntroduction,
        this.canBuyUserLevel,
        this.canBuyUserLevelArr,
        this.couponsId,
        this.giftCardId,
        this.limitAmount,
        this.limitToast,
        this.exchangedAmount});

  IntegralData.fromJson(Map<String, dynamic> json) {
    goodId = json['goodId'];
    name = json['name'];
    goodsImg = json['goodsImg'];
    price = json['price'];
    goodsType = json['goodsType'];
    goodsNumber = json['goodsNumber'];
    h5Link = json['h5Link'];
    appLink = json['appLink'];
    sort = json['sort'];
    goodsDuration = json['goodsDuration'];
    goodsDesc = json['goodsDesc'];
    goodsIntroduction = json['goodsIntroduction'];
    canBuyUserLevel = json['canBuyUserLevel'];
    if (json['canBuyUserLevelArr'] != null) {
      canBuyUserLevelArr = <CanBuyUserLevelArr>[];
      json['canBuyUserLevelArr'].forEach((v) {
        canBuyUserLevelArr!.add(new CanBuyUserLevelArr.fromJson(v));
      });
    }
    couponsId = json['couponsId'];
    giftCardId = json['giftCardId'];
    limitAmount = json['limitAmount'];
    limitToast = json['limitToast'];
    exchangedAmount = json['exchangedAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodId'] = this.goodId;
    data['name'] = this.name;
    data['goodsImg'] = this.goodsImg;
    data['price'] = this.price;
    data['goodsType'] = this.goodsType;
    data['goodsNumber'] = this.goodsNumber;
    data['h5Link'] = this.h5Link;
    data['appLink'] = this.appLink;
    data['sort'] = this.sort;
    data['goodsDuration'] = this.goodsDuration;
    data['goodsDesc'] = this.goodsDesc;
    data['goodsIntroduction'] = this.goodsIntroduction;
    data['canBuyUserLevel'] = this.canBuyUserLevel;
    if (this.canBuyUserLevelArr != null) {
      data['canBuyUserLevelArr'] =
          this.canBuyUserLevelArr!.map((v) => v.toJson()).toList();
    }
    data['couponsId'] = this.couponsId;
    data['giftCardId'] = this.giftCardId;
    data['limitAmount'] = this.limitAmount;
    data['limitToast'] = this.limitToast;
    data['exchangedAmount'] = this.exchangedAmount;
    return data;
  }
}

class CanBuyUserLevelArr {
  String? key;
  String? value;

  CanBuyUserLevelArr({this.key, this.value});

  CanBuyUserLevelArr.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}