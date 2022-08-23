class TableData {
  int? id;
  String? desc;
  int? type;
  String? jumpUrl;
  int? maxIconAmount;
  bool? canVisit;
  String? noAccessLink;

  TableData(
      {this.id,
        this.desc,
        this.type,
        this.jumpUrl,
        this.maxIconAmount,
        this.canVisit,
        this.noAccessLink});

  TableData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    desc = json['desc'];
    type = json['type'];
    jumpUrl = json['jumpUrl'];
    maxIconAmount = json['maxIconAmount'];
    canVisit = json['canVisit'];
    noAccessLink = json['noAccessLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['desc'] = this.desc;
    data['type'] = this.type;
    data['jumpUrl'] = this.jumpUrl;
    data['maxIconAmount'] = this.maxIconAmount;
    data['canVisit'] = this.canVisit;
    data['noAccessLink'] = this.noAccessLink;
    return data;
  }
}
