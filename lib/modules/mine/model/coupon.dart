class CouponData {
  int? type;
  String? name;
  int? amount;
  String? unit;
  int? toExpireAmount;
  String? toExpireHint;

  CouponData(
      {this.type,
        this.name,
        this.amount,
        this.unit,
        this.toExpireAmount,
        this.toExpireHint});

  CouponData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    amount = json['amount'];
    unit = json['unit'];
    toExpireAmount = json['toExpireAmount'];
    toExpireHint = json['toExpireHint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['unit'] = this.unit;
    data['toExpireAmount'] = this.toExpireAmount;
    data['toExpireHint'] = this.toExpireHint;
    return data;
  }
}