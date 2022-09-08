class OrderData {
  int? id;
  int? status;
  String? goodsName;
  String? realAmount;
  String? outTradeNo;
  String? vipExpiredAt;
  int? receiptStatus;
  int? goodsVersion;
  String? subPayedAmount;
  int? subPayedDeadline;
  String? refundAmount;
  String? level;
  int? goodAgreementId;
  String? image;
  int? tag;
  String? tagText;
  bool? isExpire;
  String? payedAt;
  bool? hasTicket;
  String? isOffline;
  String? tno;
  String? statusText;
  String? waitPayAmount;
  String? appDeepLink;
  String? vipExpiredAtExtra;

  OrderData(
      {this.id,
        this.status,
        this.goodsName,
        this.realAmount,
        this.outTradeNo,
        this.vipExpiredAt,
        this.receiptStatus,
        this.goodsVersion,
        this.subPayedAmount,
        this.subPayedDeadline,
        this.refundAmount,
        this.level,
        this.goodAgreementId,
        this.image,
        this.tag,
        this.tagText,
        this.isExpire,
        this.payedAt,
        this.hasTicket,
        this.isOffline,
        this.tno,
        this.statusText,
        this.waitPayAmount,
        this.appDeepLink,
        this.vipExpiredAtExtra});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    goodsName = json['goods_name'];
    realAmount = json['real_amount'];
    outTradeNo = json['out_trade_no'];
    vipExpiredAt = json['vip_expired_at'];
    receiptStatus = json['receipt_status'];
    goodsVersion = json['goods_version'];
    subPayedAmount = json['sub_payed_amount'];
    subPayedDeadline = json['sub_payed_deadline'];
    refundAmount = json['refund_amount'];
    level = json['level'];
    goodAgreementId = json['good_agreement_id'];
    image = json['image'];
    tag = json['tag'];
    tagText = json['tag_text'];
    isExpire = json['is_expire'];
    payedAt = json['payed_at'];
    hasTicket = json['has_ticket'];
    isOffline = json['is_offline'];
    tno = json['tno'];
    statusText = json['status_text'];
    waitPayAmount = json['wait_pay_amount'];
    appDeepLink = json['app_deep_link'];
    vipExpiredAtExtra = json['vip_expired_at_extra'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['goods_name'] = this.goodsName;
    data['real_amount'] = this.realAmount;
    data['out_trade_no'] = this.outTradeNo;
    data['vip_expired_at'] = this.vipExpiredAt;
    data['receipt_status'] = this.receiptStatus;
    data['goods_version'] = this.goodsVersion;
    data['sub_payed_amount'] = this.subPayedAmount;
    data['sub_payed_deadline'] = this.subPayedDeadline;
    data['refund_amount'] = this.refundAmount;
    data['level'] = this.level;
    data['good_agreement_id'] = this.goodAgreementId;
    data['image'] = this.image;
    data['tag'] = this.tag;
    data['tag_text'] = this.tagText;
    data['is_expire'] = this.isExpire;
    data['payed_at'] = this.payedAt;
    data['has_ticket'] = this.hasTicket;
    data['is_offline'] = this.isOffline;
    data['tno'] = this.tno;
    data['status_text'] = this.statusText;
    data['wait_pay_amount'] = this.waitPayAmount;
    data['app_deep_link'] = this.appDeepLink;
    data['vip_expired_at_extra'] = this.vipExpiredAtExtra;
    return data;
  }
}